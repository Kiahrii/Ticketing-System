//Elements
const getStartedBtn = document.getElementById('getStartedBtn');
const landingPage = document.getElementById('landingPage');
const formContainer = document.getElementById('formContainer');
const loginForm = document.getElementById('loginForm');

// Show form on Get Started click
getStartedBtn.addEventListener('click', () => {
  landingPage.classList.add('hide');
  setTimeout(() => {
    formContainer.classList.add('show');
  }, 500);
});
//Show specific form (login, register, forgot password)
function showForm(formId) {
  document.querySelectorAll(".form-box").forEach(form => form.classList.remove("active"));
  document.getElementById(formId).classList.add("active");
}
//Background click to return to landing page
document.querySelector('.background').addEventListener('click', function (e) {
  const isInsideForm = e.target.closest('.form-box');
  if (!isInsideForm && formContainer.classList.contains('show')) {
    formContainer.classList.remove('show');
    landingPage.classList.remove('hide');
  }
});

/*/Login Form Submit Handler
loginForm.addEventListener("submit", function (e) {
  e.preventDefault();

  const emailInput = document.getElementById("email").value.trim().toLowerCase();

  //Admin check(exact match)
  if (emailInput === "admin@upang") {
    window.location.href = "admin.html";
    return;
  }
  const phinmaEmailRegex = /^[a-z]+(\.[a-z]+)*\.up@phinmaed\.com$/;

  if (phinmaEmailRegex.test(emailInput)) {
    const usernamePart = emailInput.split("@")[0];
    window.location.href = `user.html?username=${encodeURIComponent(usernamePart)}`;
  } else {
    alert("Invalid email format! Use your PHINMA account email (e.g., jata.agas.up@phinmaed.com) or 'admin@upang' for admin.");
  }
});*/

// Login Form Submit Handler
loginForm.addEventListener("submit", async function (e) {
    e.preventDefault();
    
    const emailInput = document.getElementById("email").value.trim().toLowerCase();
    const passwordInput = document.getElementById("password").value;

    // Admin check (exact match)
    if (emailInput === "admin@upang") {
        // You might want to validate admin against database too
        if (passwordInput === "admin123") {
            window.location.href = "admin.html";
        } else {
            alert("Invalid admin password!");
        }
        return;
    }

    const phinmaEmailRegex = /^[a-z]+(\.[a-z]+)*\.up@phinmaed\.com$/;
    
    if (phinmaEmailRegex.test(emailInput)) {
        // Show loading state
        const submitBtn = loginForm.querySelector('button[type="submit"]');
        const originalText = submitBtn.textContent;
        submitBtn.textContent = "Logging in...";
        submitBtn.disabled = true;

        try {
            // Validate credentials against database
            const isValid = await validateUserWithDatabase(emailInput, passwordInput);
            
            if (isValid) {
                const usernamePart = emailInput.split("@")[0];
                window.location.href = `user.html?username=${encodeURIComponent(usernamePart)}`;
            } else {
                alert("Invalid email or password!");
            }
        } catch (error) {
            console.error('Login error:', error);
            alert("Login failed. Please try again.");
        } finally {
            // Reset button state
            submitBtn.textContent = originalText;
            submitBtn.disabled = false;
        }
    } else {
        alert("Invalid email format! Use your PHINMA account email (e.g., jata.agas.up@phinmaed.com) or 'admin@upang' for admin.");
    }
});

// Function to validate user credentials with database
async function validateUserWithDatabase(email, password) {
    try {
        const response = await fetch('/api/login', { // Adjust API endpoint as needed
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ 
                email: email, 
                password: password 
            })
        });
        
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        
        const result = await response.json();
        return result.success; // Adjust based on your API response structure
        
    } catch (error) {
        console.error('Authentication error:', error);
        return false;
    }
}