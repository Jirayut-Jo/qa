function postRequest(url, data, callback) {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onload = function() {
      if (xhr.status === 200) {
        callback(JSON.parse(xhr.responseText));
      } else {
        callback(null);
      }
    };
    xhr.send(JSON.stringify(data));
  }
  
  // ตรวจสอบสถานะการเข้าสู่ระบบ
  function isUserLoggedIn() {
    // ตรวจสอบว่าผู้ใช้ได้ป้อนข้อมูลการเข้าสู่ระบบหรือไม่
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    if (!username || !password) {
      return false; // ถ้ายังไม่กรอก username หรือ password ให้คืนค่า false ทันที
    }
  
    // ตรวจสอบว่า username และ password ถูกต้องหรือไม่
    if (username && password && username.length > 0 && password.length > 0) {
      // ตรวจสอบว่า username และ password ไม่ว่าง
      postRequest('/login', { username, password }, function(response) {
        // ตรวจสอบสถานะการเข้าสู่ระบบจาก Backend
        if (response && response.status === 200) {
          // ผู้ใช้เข้าสู่ระบบสำเร็จ
          return true;
        } else {
          // ผู้ใช้เข้าสู่ระบบไม่สำเร็จ
          return false;
        }
      });
    } else {
      // แจ้งเตือนผู้ใช้ว่า username หรือ password ไม่ถูกต้อง
      return false; // ถ้า username หรือ password ไม่ถูกต้อง ให้คืนค่า false
    }
  }
  