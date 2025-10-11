document.addEventListener('DOMContentLoaded', () => {
  //Get query parameter 'username' from the URL (if exists) or default to 'user.unknown'
  const urlParams = new URLSearchParams(window.location.search);
  const username = urlParams.get("username") || "user.unknown";

  let firstName = "User";

  //Condition
  if (username) {
    const parts = username.split(".");
    if (parts.length > 0) {
      firstName = capitalize(parts[0]);
    }
  }

  //Ir Set the profile name to the capitalized first name
  const profileName = document.getElementById("profileName");
  profileName.textContent = firstName.toUpperCase();

  //User's Capitalization function
  function capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
  }

  //DOM elements for the request modal and its parts
  const requestModal = document.getElementById("requestModal");
  const modalRoomName = document.getElementById("modalRoomName");
  const cancelRequestBtn = document.getElementById("cancelRequestBtn");
  const requestForm = document.getElementById("requestForm");
  const specifyGroup = document.getElementById("specifyGroup");
  const installSoftwareCheckbox = document.getElementById("installSoftwareCheckbox");
  const roomButtons = document.querySelectorAll(".room-card button");
  const requestsSection = document.querySelector(".request-section");

  //'No requests submitted yet' message container
  const noRequestMsg = document.querySelector("#requestList p");

  //Pop-up message
  const notification = document.createElement("div");
  notification.id = "popupNotification";
  document.body.appendChild(notification);

  //Notif message
  function showNotification(message, type = "success") {
    notification.textContent = message;


    notification.classList.remove("success", "error", "warning");

    notification.classList.add("show", type);

    //Notif interval
    setTimeout(() => {
      notification.classList.remove("show", type);
    }, 2500);
  }

  //It open the request form for a specific room
  function openRequestForm(roomName) {
    modalRoomName.textContent = roomName; // Set the room name in the modal
    requestModal.classList.remove("hidden"); //Show the modal
    document.body.style.overflow = 'hidden'; //Prevent body scrolling when modal is open
    requestForm.reset(); //Reset the form fields
    specifyGroup.style.display = "none"; //Hide software specify input by default
  }

  //Close the request form modal
  function closeRequestForm() {
    requestModal.classList.add("hidden"); //Hide the modal
    document.body.style.overflow = 'auto'; //Enable body scrolling
    requestForm.reset(); //Reset the form fields
    specifyGroup.style.display = "none"; //Hide software specify input
  }

  //This part loop through room buttons and set up click listeners to open the request form
  roomButtons.forEach(button => {
    button.addEventListener("click", () => {
      openRequestForm(button.textContent.trim());
    });
  });

  //To cancel request and close the form
  cancelRequestBtn.addEventListener("click", closeRequestForm);

  //Toggle software installation input field visibility based on checkbox
  installSoftwareCheckbox.addEventListener("change", () => {
    specifyGroup.style.display = installSoftwareCheckbox.checked ? "flex" : "none";
  });

  //Handle form submission and validate input fields
  
  requestForm.addEventListener("submit", (e) => {
    e.preventDefault(); //Prevent form from submitting normally

    //It Collect data from form fields
    const formData = new FormData(requestForm);
  //  const selectedIssues = formData.getAll("issues");
    const selectedIssues = Array.from(requestForm.querySelectorAll('input[type="checkbox"]:checked'))
    .filter(checkbox => checkbox !== installSoftwareCheckbox)
    .map(checkbox => checkbox.value);
    const specify = formData.get("specify");
    const otherIssue = formData.get("otherIssue");
    const selectedPriority = formData.getAll("priority");

    //Validation
    const hasBasicIssues = selectedIssues.length > 0;
    const hasInstallSoftware = installSoftwareCheckbox.checked && specify.trim() !== "";
    const hasOtherIssue = otherIssue.trim() !== "";
    //if (!hasBasicIssues && !hasInstallSoftware && !hasOtherIssue) {
      //showNotification("Please choose at least one issue.", "error");
      //return;
    //}

    //Conditonals
    if (installSoftwareCheckbox.checked && specify.trim() === "") {
      showNotification("Please specify the software you want to install.", "error");
      return;
    }

    //It checks if priority is selected and exactly one priority is chosen
    //This part is for Conditonals
    if (selectedPriority.length === 0) {
      showNotification("Choose your priority.", "error");
      return;
    }

    if (selectedPriority.length !== 1) {
      showNotification("Choose only one priority.", "error");
      return;
    }

    //This part remove the "No requests submitted yet" message after the first request
    if (noRequestMsg) {
      noRequestMsg.style.display = "none";
    }

    //This part prepare data to display in the request box (room, issues, and priority)
    const room = modalRoomName.textContent;
    const fullIssues = [...selectedIssues];
    if (installSoftwareCheckbox.checked && specify.trim() !== "") {
      fullIssues.push(`Install: ${specify}`);
    }
    if (otherIssue.trim() !== "") {
      fullIssues.push(`Other: ${otherIssue}`);
    }

    //Get the current date in a readable formatZ
    const today = new Date();
    const dateString = today.toLocaleDateString('en-US', {
      year: 'numeric', month: 'long', day: 'numeric'
    });

    //This part create a new request box to display the request
    const requestBox = document.createElement("div");
    requestBox.className = "request-box";

    //It add the date of the request to the request box
    const dateLabel = document.createElement("p");
    dateLabel.className = "request-date";
    dateLabel.textContent = `DATE: ${dateString}`;
    requestBox.appendChild(dateLabel);

    //This part create the content box for the request details
    const contentBox = document.createElement("div");
    contentBox.className = "request-content";

    //This part create delete button (with an SVG icon) for the request
    const deleteBtn = document.createElement("button");
    deleteBtn.className = "delete-btn";
    deleteBtn.title = "Delete request";
    deleteBtn.innerHTML = `
      <img src="../assetsdelete-1-svgrepo-com.svg" alt="Delete" width="30" height="30">
    `;

    // Delete button functionality: remove the request box and show notification
    deleteBtn.addEventListener("click", () => {
      requestBox.remove(); //It remove the request box
      showNotification("DELETED", "warning"); //It show notif

      //This part show the "No requests submitted yet" message if no requests remain
      if (requestsSection.querySelectorAll(".request-box").length === 0 && noRequestMsg) {
        noRequestMsg.style.display = "block";
      }
    });

    //This part build the content of the request box (room, issues, and priority)
    contentBox.innerHTML = `
      <p><strong>Room:</strong> ${room}</p>
      <p style="display:flex; justify-content: space-between; align-items: center;">
        <span><strong>Issues:</strong> ${fullIssues.join(", ")}</span>
      </p>
      <p><strong>Priority:</strong> ${selectedPriority[0]}</p>
    `;


    const issuesParagraph = contentBox.querySelector("p:nth-child(2)");
    issuesParagraph.style.display = "flex";
    issuesParagraph.style.justifyContent = "space-between";
    issuesParagraph.style.alignItems = "center";
    issuesParagraph.appendChild(deleteBtn);

    //This part append the content box to the request box and add the request box to the requests section
    requestBox.appendChild(contentBox);
    requestsSection.appendChild(requestBox);

    showNotification("Request Sent", "success"); //This show success notif
    closeRequestForm();
  });

  //Navigation between rooms and requests sections
  const navRooms = document.getElementById("navRooms");
  const navRequests = document.getElementById("navRequests");
  const roomsSection = document.querySelector(".rooms-section");

  navRooms.addEventListener("click", () => {
    roomsSection.style.display = "block";
    requestsSection.style.display = "none";
  });

  navRequests.addEventListener("click", () => {
    roomsSection.style.display = "none";
    requestsSection.style.display = "block";
  });

  //Set default display state (rooms section visible, requests section hidden)
  roomsSection.style.display = "block";
  requestsSection.style.display = "none";
});

//Logout Logic
const logoutBtn = document.getElementById("logoutBtn");
const logoutModal = document.getElementById("logoutModal");
const confirmLogoutBtn = document.getElementById("confirmLogoutBtn");
const cancelLogoutBtn = document.getElementById("cancelLogoutBtn");

//Toast notification function (same as Admin Dashboard)
function showToast(message, bgColor = "#4caf50") {
  const toast = document.createElement("div");
  toast.className = "notify";
  toast.style.backgroundColor = bgColor;
  toast.textContent = message;
  document.body.appendChild(toast);

  setTimeout(() => toast.classList.add("show"), 100);
  setTimeout(() => {
    toast.classList.remove("show");
    setTimeout(() => toast.remove(), 300);
  }, 2000);
}

//This part show logout modal when logout button is clicked
logoutBtn.addEventListener("click", () => {
  logoutModal.classList.remove("hidden");
});


//Confirm logout
confirmLogoutBtn.addEventListener("click", () => {
  showToast("Logging out...", "#f44336");
  setTimeout(() => {
    window.location.href = "index.html"; // It redirect to landing page
  }, 1000);
});

//Cancel logout
cancelLogoutBtn.addEventListener("click", () => {
  logoutModal.classList.add("hidden");
});