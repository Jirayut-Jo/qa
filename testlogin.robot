*** Settings ***
Library   PuppeteerLibrary 
Library   Dialogs
Test Teardown    Close Browser


*** Test Cases ***
Example login form submit
    ${HEADLESS}     Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    https://www.facebook.com/    options=${options}
    Input text    xpath://*[@id="email"]    possible0576@hotmail.com
    Click Element    xpath://*[@id="pass"]
    Input text    xpath://*[@id="pass"]    jo0891840673
    Run Async Keywords
    ...    Click Element    xpath=//*[@type="submit"]   AND
    ...    Wait For Response Url    https://www.facebook.com/
    Wait Until Page Contains   Login succeeded
Default Test Tesrdown   
    Close All Browser


