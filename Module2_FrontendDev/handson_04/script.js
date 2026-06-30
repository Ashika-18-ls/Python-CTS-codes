const taskContainer = document.getElementById("taskContainer");

async function loadTasks(){
    const response = await fetch("https://jsonplaceholder.typicode.com/todos?_limit=5");
    const data = await response.json();
  
    data.forEach(task => {
        const div = document.createElement("div");
        div.className = "task";
        div.innerHTML = `
            <h3>${task.title}</h3>
            <p>Status : ${task.completed ? "Completed ✅" : "Pending ❌"}</p>
        `;
        taskContainer.appendChild(div);
    });
}

loadTasks();
