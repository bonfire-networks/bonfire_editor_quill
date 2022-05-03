import Quill from "quill";
import QuillMarkdown from 'quilljs-markdown'
import "quill-mention";
import { Picker } from 'emoji-mart'


let EditorQuillHooks = {};

EditorQuillHooks.QuillEditor = { 
  mounted() {
    console.log("editor - quill loading for elements with class .editor_area");

    area = this.el.querySelector("#editor")

    const quill = new Quill(area, {
      theme: 'bubble',
      placeholder: area.dataset.placeholder,
      modules: {
        mention: {
          allowedChars: /^[A-Za-z0-9_\-.]*$/,
          fixMentionsToQuill: true,
          mentionDenotationChars: ["@", "&", "+"],
          showDenotationChar: true,
          blotName: 'text',
          spaceAfterInsert: false,
          source: async function(searchTerm, renderList, mentionChar) {
            const matchedValues = await getFeedItems(searchTerm, mentionChar)
            renderList(matchedValues)
          },
          onSelect: function (item, insertItem) {
            // item.value = item.id;
            // console.log(item)
            // insertItem(item)
            insertItem(item.id + " ") // if using 'text' blot
            // end = this.cursorPos + item.id.length
            quill.setSelection(quill.getLength(), 0); // TODO: move cursor after mention
          },
          renderItem: function(item, searchTerm) {
            return `
              <div class="flex flex-col py-2">
                <div class="text-sm font-semibold">${item.value}</div>
                <div class="text-xs text-opacity-70 font-regular">${item.id}</div>
              </div>
            `;
          }
        }
      }
    });

    // markdown is enabled
    const quillMarkdown = new QuillMarkdown(quill, { ignoreTags: ['ul', 'ol', 'checkbox']})

    const picker = new Picker({
      emojiButtonSize: 30,
      emojiSize: 20,
      previewPosition: 'none',
      onEmojiSelect: function(emoji) {
        const range = quill.getSelection() 
        quill.insertText(range.index, emoji.native + ' ', 'user', true)
      },
      data: async () => {
        const response = await fetch(
          'https://cdn.jsdelivr.net/npm/@emoji-mart/data',
        )
    
        return response.json()
      }
    })
    
    // Assuming there is a <form class="form_with_editor"> in your application.
    document.querySelector('.form_with_editor').addEventListener('submit', (event) => {
      
      this.el.querySelector('.editor_hidden_input').value = quill.root.innerHTML;
      quill.setText(''); // empty the editor ready for next post
    });

    // return quill
    document.querySelector('#picker').appendChild(picker)
  },
};


function getFeedItems(queryText, prefix) {
  // console.log(prefix)
  if (queryText && queryText.length > 0) {
    return new Promise((resolve) => { 
      // this requires the bonfire_tag extension
      fetch("/api/tag/autocomplete/ck5/" + prefix + "/" + queryText)
        .then((response) => response.json())
        .then((data) => {
          let values = data.map((item) => ({
            id: item.id,
            value: item.name,
            link: item.link
          }))
          // console.log(values);
          resolve(values);
        })
        .catch((error) => {
          console.error("There has been a problem with the tag search:", error);
          resolve([]);
        });
    });
  } else return [];
}

export { EditorQuillHooks }