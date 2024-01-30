*** Settings ***
Library    PuppeteerLibrary
Suite Teardown       Close Puppeteer 
Test Teardown     Close Browser

*** Variables ***
${DEFAULT_BROWSER}    chrome
${HOME_PAGE_URL}    http://localhost:5500/frontend/


*** Test Cases ***
Example login form submit
    ${BROWSER} =     Get variable value    ${BROWSER}    ${DEFAULT_BROWSER}
    ${HEADLESS} =    Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    ${HOME_PAGE_URL}    browser=${BROWSER}    options=${options}
#Register succeeded  
    Input text    xpath://*[@id="register-username"]    test9
    Input text    xpath://*[@id="register-password"]   1234
    Click Element    xpath=//*[@id="register-btn"]
#Login succeeded
    Input text    xpath://*[@id="login-username"]    test9
    Input text    xpath://*[@id="login-password"]   1234
    Click Element    xpath=//*[@id="login-btn"]

#Newpasswork succeeded
    Input text    xpath://*[@id="change-username"]    test9
    Input text    xpath://*[@id="change-password"]   12345
    Run Async Keywords
    Click Element    xpath=//*[@id="change-password-btn"]
#Delete succeeded
    Input text    xpath://*[@id="delete-username"]    test9
    Input text    xpath://*[@id="delete-password"]   12345
    Run Async Keywords
    Click Element    xpath=//*[@id="delete-user-btn"]
Default Test Tesrdown   
    Close All Browser