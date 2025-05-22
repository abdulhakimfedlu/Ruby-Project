import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    const taskId = this.element.dataset.taskId
    const completed = event.target.checked

    fetch(`/tasks/${taskId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ task: { completed: completed } })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok')
      }
      const label = event.target.nextElementSibling
      label.textContent = completed ? 'Completed' : 'Pending'
    })
    .catch(error => {
      console.error('Error:', error)
      event.target.checked = !completed
    })
  }
} 