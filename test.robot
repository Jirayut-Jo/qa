* Settings *
Library           RequestsLibrary

* Variables *
${BASE_URL}       http://localhost:3000

* Test Cases *
Register User
    Create Session    session    ${BASE_URL}
    &{data}=    Create Dictionary    username=testuser    password=testpass
    ${response}=    Post Request    session    /register    json=${data}
    Check Response Code    ${response.status_code}    200

Login User
    Create Session    session    ${BASE_URL}
    &{data}=    Create Dictionary    username=testuser    password=testpass
    ${response}=    Post Request    session    /login    json=${data}
    Check Response Code    ${response.status_code}    200

Update User Password
    Create Session    session    ${BASE_URL}
    &{data}=    Create Dictionary    username=testuser    newPassword=newpass123
    ${response}=    Put Request    session    /update    json=${data}
    Check Response Code    ${response.status_code}    200

Delete User
    Create Session    session    ${BASE_URL}
    &{data}=    Create Dictionary    username=testuser
    ${response}=    Delete Request    session    /delete    json=${data}
    Check Response Code    ${response.status_code}    200

Get All Users
    Create Session    session    ${BASE_URL}
    ${response}=    Get Request    session    /users
    Check Response Code    ${response.status_code}    200

* Keywords *
Check Response Code
    [Arguments]    ${actual_code}    ${expected_code}
    Run Keyword If    '${actual_code}' != '${expected_code}'    Fail    Expected status code to be '${expected_code}' but was '${actual_code}'.
