import React, { useState, useEffect } from 'react';

function App() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState('');

  useEffect(() => {
    fetch('a3fa7814e7a8146ed852e8fe2dcb7028-7477371.us-east-1.elb.amazonaws.com/backend/tasks')
      .then((response) => response.json())
      .then((data) => setTasks(data));
  }, []);

  const addTask = async () => {
    if (!newTask.trim()) return;
    const response = await fetch('a3fa7814e7a8146ed852e8fe2dcb7028-7477371.us-east-1.elb.amazonaws.com/backend/tasks', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title: newTask }),
    });
    const task = await response.json();
    setTasks([...tasks, task]);
    setNewTask('');
  };

  const deleteTask = async (id) => {
    await fetch(`a3fa7814e7a8146ed852e8fe2dcb7028-7477371.us-east-1.elb.amazonaws.com/backend/tasks/${id}`, { method: 'DELETE' });
    setTasks(tasks.filter((task) => task.id !== id));
  };

  return (
    <div style={{ maxWidth: '600px', margin: 'auto', textAlign: 'center' }}>
      <h1>Task Manager</h1>
      <div>
        <input
          type="text"
          value={newTask}
          onChange={(e) => setNewTask(e.target.value)}
          placeholder="Add a new task"
          style={{ padding: '10px', width: '70%' }}
        />
        <button onClick={addTask} style={{ padding: '10px' }}>
          Add Task
        </button>
      </div>
      <ul style={{ listStyle: 'none', padding: 0, marginTop: '20px' }}>
        {tasks.map((task) => (
          <li key={task.id} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '10px' }}>
            <span>{task.title}</span>
            <button onClick={() => deleteTask(task.id)}>Delete</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
