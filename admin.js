document.addEventListener('DOMContentLoaded', () => {
  //Directly set the Admin name
  const adminName = document.getElementById("adminName");
  if (adminName) {
    adminName.textContent = "ADMIN";
  }
});


document.addEventListener('DOMContentLoaded', () => {
  //Tab Switching
  const tabs = document.querySelectorAll('.tab-btn');
  const sections = document.querySelectorAll('.tab-section');

  tabs.forEach((tab, index) => {
    tab.addEventListener('click', () => {
      tabs.forEach(t => t.classList.remove('active'));
      sections.forEach(s => s.classList.remove('active'));
      tab.classList.add('active');
      sections[index].classList.add('active');
    });
  });

  

  //Dashboard logic
  const dashboardSection = document.querySelector('.dashboard-section');
  if (!dashboardSection) return;

  const statsGrid = dashboardSection.querySelector('.stats-grid');
  const requestFilters = dashboardSection.querySelector('.request-filters');
  const requestsSection = dashboardSection.querySelector('.requests-section');

  const dashboardButtons = dashboardSection.querySelectorAll('.dashboard-buttons .dash-btn');
  const btnRequest   = dashboardButtons[0];
  const btnPending   = dashboardButtons[1];
  const btnCompleted = dashboardButtons[2];

  //Containers for pending and completed
  const pendingContainer = document.createElement('div');
  pendingContainer.className = 'requests-section pending-requests';
  pendingContainer.style.display = 'none';
  dashboardSection.appendChild(pendingContainer);

  const completedContainer = document.createElement('div');
  completedContainer.className = 'requests-section completed-requests';
  completedContainer.style.display = 'none';
  dashboardSection.appendChild(completedContainer);

  //Hide bottom sections initially
  function hideBottomSections() {
    [requestFilters, requestsSection, pendingContainer, completedContainer].forEach(el => {
      if (el) {
        el.style.display = 'none';
        el.classList.remove('pop-up');
      }
    });
  }
  hideBottomSections();

  //Show bottom section with transition
  function showWithTransition(el) {
    if (!el) return;
    el.style.display = 'flex';
    el.classList.remove('pop-up');
    void el.offsetWidth; //Trigger reflow
    el.classList.add('pop-up');
  }

  //Logic for showing each section
  
  // Preserve scroll position for all button actions
function preserveScroll(action) {
  const scrollY = window.scrollY;
  action();
  requestAnimationFrame(() => {
    window.scrollTo(0, scrollY);
  });
}

function showRequestView() {
  preserveScroll(() => {
    hideBottomSections();
    showWithTransition(requestFilters);
    showWithTransition(requestsSection);
  });
}

function showPendingView() {
  preserveScroll(() => {
    hideBottomSections();
    showWithTransition(pendingContainer);
  });
}

function showCompletedView() {
  preserveScroll(() => {
    hideBottomSections();
    showWithTransition(completedContainer);
  });
}


  // function showRequestView() {
  //   hideBottomSections();
  //   showWithTransition(requestFilters);
  //   showWithTransition(requestsSection);
  // }

  // function showPendingView() {
  //   hideBottomSections();
  //   showWithTransition(pendingContainer);
  // }

  // function showCompletedView() {
  //   hideBottomSections();
  //   showWithTransition(completedContainer);
  // }

  //Button click and double-click logic
  btnRequest.addEventListener('click', showRequestView);
  btnRequest.addEventListener('dblclick', hideBottomSections);

  btnPending.addEventListener('click', showPendingView);
  btnPending.addEventListener('dblclick', hideBottomSections);

  btnCompleted.addEventListener('click', showCompletedView);
  btnCompleted.addEventListener('dblclick', hideBottomSections);


//Create Requezt Box
function createRequestBox(requestorName, priority, reportText, roomName) {
  const group = document.createElement('div');
  group.className = 'request-group';

  //Date
  const dateElement = document.createElement('div');
  dateElement.className = 'date';
  dateElement.textContent = new Date().toLocaleDateString();
  group.appendChild(dateElement);

  //Request Box
  const requestBox = document.createElement('div');
  requestBox.className = 'request-box';

  //Left Icon
  const iconElement = document.createElement('img');
  iconElement.className = 'request-icon';
  iconElement.src = '../assets/user-svgrepo-com.svg';
  iconElement.alt = 'Request Icon';
  requestBox.appendChild(iconElement);

  //Content Container
  const contentContainer = document.createElement('div');
  contentContainer.className = 'request-content';

  //Requestor Name
  const requestorElement = document.createElement('div');
  requestorElement.className = 'requestor';
  requestorElement.textContent = `Requestor: ${requestorName}`;
  contentContainer.appendChild(requestorElement);

  //Report Text
  const reportElement = document.createElement('div');
  reportElement.className = 'report';
  reportElement.textContent = `Report: ${reportText}`;
  contentContainer.appendChild(reportElement);

  //Room Name (below Report)
  const roomElement = document.createElement('div');
  roomElement.className = 'room';
  roomElement.textContent = `Room: ${roomName}`;
  contentContainer.appendChild(roomElement);

  //Bottom Row: Priority + Buttons
  const bottomRow = document.createElement('div');
  bottomRow.className = 'bottom-row';

  //Priority Indicator
  const priorityElement = document.createElement('div');
  priorityElement.className = `priority ${priority.toLowerCase()}`;
  bottomRow.appendChild(priorityElement);

  //Buttons
  const buttonsContainer = document.createElement('div');
  buttonsContainer.className = 'buttons';

  const acceptButton = document.createElement('button');
  acceptButton.className = 'dash-btn accept-btn';
  acceptButton.textContent = 'Accept';

  const declineButton = document.createElement('button');
  declineButton.className = 'dash-btn decline-btn';
  declineButton.textContent = 'Decline';

  buttonsContainer.appendChild(acceptButton);
  buttonsContainer.appendChild(declineButton);
  bottomRow.appendChild(buttonsContainer);

  contentContainer.appendChild(bottomRow);
  requestBox.appendChild(contentContainer);
  group.appendChild(requestBox);

  //This append to main requests section
  requestsSection.appendChild(group);
}

//EXAMPLE ONLY - _ -
createRequestBox('Jan Lewis', 'Low', 'Missing keyboard', 'ITS 200');
createRequestBox('Keziah Garcia', 'High', 'Missing keyboard', 'ITS 201');



  //Acdept-Done-Decline Logic
  dashboardSection.addEventListener('click', (e) => {
    const group = e.target.closest('.request-group');
    if (!group) return;

    //Accept - move to 'Pending container, button becomes Done
    if (e.target.classList.contains('accept-btn')) {
      const pendingBox = group.cloneNode(true);
      const buttons = pendingBox.querySelector('.buttons');
      const acceptBtn = pendingBox.querySelector('.accept-btn');
      acceptBtn.textContent = 'Done';
      acceptBtn.classList.remove('accept-btn');
      acceptBtn.classList.add('done-btn');
      pendingContainer.appendChild(pendingBox);
      group.remove(); //Remove from Request tab
    }

    //Done - move to 'Completed container, replace button with "Completed" text
    if (e.target.classList.contains('done-btn')) {
      const buttonsContainer = group.querySelector('.buttons');
      const doneText = document.createElement('div');
      doneText.textContent = 'Completed';
      doneText.style.fontWeight = 'bold';
      doneText.style.color = '#2e7d32';
      doneText.style.marginLeft = 'auto';
      doneText.style.alignSelf = 'center';

      buttonsContainer.replaceWith(doneText);
      completedContainer.appendChild(group);
    }

    //Decline - remove request wherever it is
    if (e.target.classList.contains('decline-btn')) {
      group.remove();
    }
  });
});


//WALANG JS ANG PROFILE TAB//

//Manage Account JS//
document.addEventListener('DOMContentLoaded', () => {
  const accountsList = document.querySelector('.accounts-list');
  const addBtn = document.querySelector('.add-account-btn');
  const deleteModal = document.querySelector('.delete-modal');
  const modalYes = deleteModal.querySelector('.modal-yes');
  const modalNo = deleteModal.querySelector('.modal-no');
  let rowToDelete = null;

  //CLICK "+ Add Account"
  addBtn.addEventListener('click', () => {
    //Create editable row
    const newRow = document.createElement('div');
    newRow.className = 'account-row';

    newRow.innerHTML = `
      <div class="account-info">
        <span class="bg-text"><input type="text" class="edit-input" placeholder="Username"></span>
        <span class="bg-text"><input type="text" class="edit-input" placeholder="Name"></span>
        <span class="bg-text">Active</span>
      </div>
      <div class="account-actions">
        <button class="dash-btn edit-btn">
          <img src="../assets/edit-svgrepo-com.svg" class="action-icon"> Save
        </button>
        <button class="decline-btn delete-btn">
          <img src="../assets/delete-1-svgrepo-com.svg" class="action-icon"> Delete
        </button>
      </div>
    `;
    accountsList.appendChild(newRow);
  });

  //CLICK inside accounts list (Edit/Delete)
  accountsList.addEventListener('click', (e) => {
    const deleteBtn = e.target.closest('.delete-btn');
    const editBtn = e.target.closest('.edit-btn');

    //Delete Logic
    if (deleteBtn) {
      rowToDelete = deleteBtn.closest('.account-row');
      deleteModal.classList.remove('hidden');
    }

    //Edit/Save Logic
    if (editBtn) {
      const row = editBtn.closest('.account-row');
      const inputs = row.querySelectorAll('.account-info .edit-input');

      if (editBtn.textContent.trim() === "Save") {
        //Check if inputs are filled
        if (!inputs[0].value.trim() || !inputs[1].value.trim()) {
          showToast("Username and Name cannot be empty.", "#ff9800");
          return;
        }
        //Save values
        row.querySelectorAll('.account-info .bg-text')[0].textContent = inputs[0].value;
        row.querySelectorAll('.account-info .bg-text')[1].textContent = inputs[1].value;
        editBtn.innerHTML = `<img src="../assets/edit-svgrepo-com.svg" class="action-icon"> Edit`;
        showToast("Account Added", "#4caf50");
      } else if (editBtn.textContent.trim() === "Edit") {
        //Turn into editable
        const infoSpans = row.querySelectorAll('.account-info .bg-text');
        infoSpans[0].innerHTML = `<input type="text" value="${infoSpans[0].textContent}" class="edit-input">`;
        infoSpans[1].innerHTML = `<input type="text" value="${infoSpans[1].textContent}" class="edit-input">`;
        editBtn.innerHTML = `<img src="../assets/edit-svgrepo-com.svg" class="action-icon"> Save`;
      }
    }
  });

  //Confirm Delete
  modalYes.addEventListener('click', () => {
    if (rowToDelete) rowToDelete.remove();
    deleteModal.classList.add('hidden');
    showToast("Deleted", "#f44336");
    rowToDelete = null;
  });

  modalNo.addEventListener('click', () => {
    deleteModal.classList.add('hidden');
    rowToDelete = null;
  });

  //Notify
  function showToast(message, bgColor = "#4caf50") {
    const toast = document.createElement('div');
    toast.className = 'notify';
    toast.style.backgroundColor = bgColor;
    toast.textContent = message;
    document.body.appendChild(toast);

    setTimeout(() => toast.classList.add('show'), 100);
    setTimeout(() => {
      toast.classList.remove('show');
      setTimeout(() => toast.remove(), 300);
    }, 2000);
  }
});


//Logout Logic(Admin)
const adminLogoutBtn = document.getElementById("logoutBtn");
const adminLogoutModal = document.getElementById("adminLogoutModal");
const adminConfirmLogoutBtn = document.getElementById("adminConfirmLogoutBtn");
const adminCancelLogoutBtn = document.getElementById("adminCancelLogoutBtn");

//Notify
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

// Show logout modal on icon click
adminLogoutBtn.addEventListener("click", () => {
  adminLogoutModal.classList.remove("hidden");
});

// Confirm logout
adminConfirmLogoutBtn.addEventListener("click", () => {
  showToast("Logging out...", "#f44336");
  setTimeout(() => {
    window.location.href = "index.html"; // Redirect to landing page
  }, 1000);
});

// Cancel logout
adminCancelLogoutBtn.addEventListener("click", () => {
  adminLogoutModal.classList.add("hidden");
});

