*** Settings ***
Library    SeleniumLibrary    #auto_close=${FALSE}

*** Variables ***
${BROWSER}    chrome
${URL}    https://codenboxautomationlab.com/practice/

*** Keywords ***


*** Test Cases ***
CodenBox AutomationLab
    Open Browser   ${URL}   ${BROWSER}
    maximize browser window
#Radio Button Example
    page should contain radio button    xpath:(//input[@name='radioButton'])
    sleep  2
    select radio button    radioButton   radio2
    radio button should be set to  radioButton   radio2
#Dynamic Dropdown Example
    click element     xpath://input[@id='autocomplete']
    input text     id:autocomplete     thai
    click element    id:autocomplete   action_chain=True
#Static Dropdown Example
    Wait Until Element Is Visible  id:dropdown-class-example  timeout=5
    Select From List By Index  id:dropdown-class-example  option1
    List Selection Should Be  id:dropdown-class-example  option1
    Select From List By Value  id:dropdown-class-example  option3
    List Selection Should Be  id:dropdown-class-example  option3
    Close browser