    [ToC]

# Getting Started with SpecFlow

    > [官方地址](https://specflow.org/getting-started/)

## 1.Installing and Setup

    1. 安装Visual Studio Extension
      + [Visual Studio 2019插件](https://marketplace.visualstudio.com/items?itemName=TechTalkSpecFlowTeam.SpecFlowForVisualStudio)
      + [Visual Studio 2017插件](https://marketplace.visualstudio.com/items?itemName=TechTalkSpecFlowTeam.SpecFlowforVisualStudio2017)

    2. 使用SpecFlow 启动 VS 项目
      1. Add an “MSTest Test Project (.NET Core)” to your solution (e.g. “MyProject.Specs”).
         Note: Adding this simplifies the setup, as we will be using the .NET Core framework for this project. For a Full Framework project, select “Unit Test Project (.NET Framework)” instead.
      2. Remove the UnitTest1.cs file, as it is not required.
      3. Right-click on your solution (e.g. “MyProject.Specs”) and select Manage NuGet Packages for Solution.
      4. Install the following packages (use the search field to filter the search results):
        + SpecFlow
        + SpecFlow.Tools.MsBuild.Generation
        + SpecRun.SpecFlow
      5. The Microsoft .NET Test SDK is also required. If you do not have it in your project yet, please install it as well.

## 2.Adding a Feature File

    1. Right-click on your specifications project and select Add | New Item from the popup menu.
    2. Select SpecFlow Feature File (restrict the entries by entering “SpecFlow” in the search field), give it a meaningful name(e.g. “Calculator.feature”) and click on Add.

## 3.Generating Step Definitions

    1. Right-click on your feature file in the code editor (!) and select Generate Step Definitions from the popup menu. A dialogue is displayed.
    2. Enter a name for the class, e.g. “CalculatorSteps”.
    3. Click on Generate and save the file. A new skeleton class is added to your project with steps for each of the steps in the scenario:
    1. 

## 4.Executing your first test

    1. Build your solution.
    2. Select Test | Windows | Test Explorer to open the Test Explorer:
    3. Click on Run All to run your test.
    4. You will be asked to sign up for a SpecFlow account or to sign in with your existing account.To see the output of the SpecFlow+ Runner please open the “Output” pane and select “Tests” in the “Show output from” dropdown:
    5. Open the URL in the message in your browser. In Visual Studio you can click the link while pressing the CTRL-key.
    6. You are displayed with a “Welcome Page”. Click on Sign in with Microsoft to continue.
    7. Sign in with your Microsoft account. It can be a personal or corporate/enterprise account. If you are already signed in, this should happen automatically –you might need additional permissions from your Active Directory admin. Learn more about admin consents
    8. You will be taken to a setup page where you can set up your SpecFlow account. Enter your details to sign up for a free SpecFlow account.
    9. Return to Visual Studio and click on “Run all” again.
    10. As the automation and application code has not yet been implemented, the test will not pass successfully

## 5.Implementing the Automation and Application Code

    > In order for your tests to pass, you need to implement both the application code (the code in your application you are testing) and the automation code (binding the test scenario to the automation interface). This involves the following steps, which are covered in this section:

        1. Reference the assembly or project containing the interface you want to bind the automation to (including APIs, controllers, UI automation tools etc.).
        2. Extend the step definition skeleton with the automation code.
        3. Implement the missing application code.
        4. Verify that the scenario passes the test. 

    ### 1.Adding a Calculator Class
        > The application code that implements the actual functions performed by the calculator should be defined in a separate project from your specification project. This project should include a class for the calculator and expose methods for initialising the calculator and performing the addition:
            1. Right-click on your solution in the Solution Explorer and select Add | Project from the context menu. Choose to add a new class library and give your project a name (e.g. “Example”).
            2. Right-click on the .cs file in the new project and rename it (e.g. “Calculator.cs”), and choose to rename all references.
            3. Your new class should be similar to the following:
                ```C#
                namespace Example
                {
                    public class Calculator
                    {
                    }
                }
                ```

    ### 2.Referencing the Calculator Class
            1. Right-click your specification project and select Add | Reference from the context menu.
            2. Click on Projects on the left of the Reference Manager dialogue. The projects in your solution are listed.
            3. Enable the check box next to the Example project to reference it from the specifications project.
            4. Click on OK.A reference to the Example project is added to the References node in the Solution Explorer.
            5. Add a using directive for the namespace (e.g. “Example”) of your Calculator class to the CalculatorSteps.cs file in your specification project
                ```C# 
                using Example;
                ```
            6. Define a variable of the type Calculator in the CalculatorSteps class prior to the step definitions
                ```aspx-csharp
                public class CalculatorSteps
                {
                    private Calculator calculator = new Calculator();
                    [Given(@"I have entered (.*) into the calculator")]
                ```
            1. 
    ### 3.Implementing the Code
        > Now that the step definitions can reference the Calculator class, you need to extend the step definitions and implement the application code.

    ### 4.Binding the First Given Statement