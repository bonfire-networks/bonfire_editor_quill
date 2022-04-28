// using a pre-built editor because of troubles building ck's sass with esbuild
// it can be customised in ./ckeditor (see package.json and src/ckeditor.js) and rebuilt with npm/webpack
import Quill from "quill";
import "quill-mention";
import QuillMarkdown from 'quilljs-markdown'
import 'quilljs-markdown/dist/quilljs-markdown-common-style.css'


let EditorQuillHooks = {};


EditorQuillHooks.MarkdownEditor = { 
  mounted() {
    console.log("editor - quill loading for elements with class .editor_area");

    area = this.el.querySelector("#editor")

    const quill = new Quill(area, {
      theme: 'bubble',
      placeholder: area.dataset.placeholder,
      modules: {
        mention: {
          allowedChars: /^[A-Za-z\sÅÄÖåäö]*$/,
          mentionDenotationChars: ["@", "&", "+"],
          source: async function(searchTerm, renderList, mentionChar) {
            const matchedValues = await getFeedItems(searchTerm, mentionChar)
            renderList(matchedValues)
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

    const markdownOptions = {
      ignoreTags: [ 'a', 'h1', 'h2'], // @option - if you need to ignore some tags.
    }
    const quillMD = new QuillMarkdown(quill, markdownOptions)

     // Assuming there is a <form class="form_with_editor"> in your application.
     document.querySelector('.form_with_editor').addEventListener('submit', (event) => {
      const deltaOps = quill.getContents();
      
      const html = quill.root.innerHTML

      console.log(deltaOps)
      
      console.log(html)
      this.el.querySelector('.editor_hidden_input').value = html;
    });

    // return quill
    
  },
};


// function getFeedItems_users(queryText) {
//   return getFeedItems(queryText, "@");
// }
// function getFeedItems_groups(queryText) {
//   return getFeedItems(queryText, "&");
// }
// function getFeedItems_extras(queryText) {
//   return getFeedItems(queryText, "+");
// }

function getFeedItems(queryText, prefix) {
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
          console.log(values);
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