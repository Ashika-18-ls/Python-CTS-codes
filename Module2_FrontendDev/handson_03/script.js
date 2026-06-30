const button = document.getElementById("btn");
const message = document.getElementById("message");
const container = document.getElementById("courseContainer");

button.addEventListener("click", function(){

    message.innerHTML = "Happy Learning! 🚀";

    button.innerHTML = "Course Opened";

});

const newCard = document.createElement("div");

newCard.className = "card";

newCard.innerHTML = `
<h3>React JS</h3>
<p>Modern Frontend Framework</p>
`;

container.appendChild(newCard);
