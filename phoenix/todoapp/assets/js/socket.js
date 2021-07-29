import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})


socket.connect()

// Now that you are connected, you can join channels with a topic:

const createSocket = (topicId) => {
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
    .receive("ok", resp => { 
      console.log("Joined successfully", resp.todo) 
      renderComments(resp.todo.comments)
    })
    .receive("error", resp => { console.log("Unable to join", resp) });

    channel.on(`comments:${topicId}:new`, renderComment);


    document.querySelector("#form-new-comment").addEventListener("submit", function(e) {
      e.preventDefault();
      const content = document.querySelector("#comment_title").value;
      channel.push("comment:add", {content: content})
    })
}

function renderComment(event) {
    const content = `<li>${event.comment.title}</li>`;
    document.querySelector("#comments").insertAdjacentHTML("afterbegin", content);
}

function renderComments(comments) {
  const commentContainer = document.querySelector("#comments");
  const content = comments.map(comment => {
    return `
      <li>
        ${comment.title}
      </li>
    `;
  });
  commentContainer.innerHTML = content.join("");

}

window.createSocket = createSocket;

