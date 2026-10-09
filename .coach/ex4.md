<!-- Generated from the AD265 instructions repo (ex4/README.md); images stripped. Do not hand-edit — re-run .gen-readmes.sh. -->

# Exercise 4 - Enhance Your MDK App with Agentic AI via MCP Server

## Estimated time

:clock4: 15 minutes

## Objective

In this exercise, you will learn how to enhance your MDK app using agentic AI through **Cline**, the AI assistant pre-installed in VS Code on your machine. Cline is connected to the **MDK MCP Server** (`mdk-mcp`), which exposes various MDK generator tools (such as `mdk-gen`) to the assistant. You'll generate translation files (i18n) in one or more languages, containing key-value string pairs that support localization. This allows your application to cater to a diverse audience and improves accessibility for users across different regions.

> **Tip:** Cline was configured for you by the `setup-cline.bat` script (see [`setup/cline/`](../../../setup/cline/README.md)), which set up the SAP AI Core connection and the `mdk-mcp` server. If the Cline panel shows a welcome/onboarding screen instead of a ready chat, run that setup step again before continuing.


| Exercise Number   | Title                                                 |
|-------------------|-------------------------------------------------------|
| [Exercise 4.1](#exercise-41---generate-i18n-files-in-one-or-more-languages) | Generate i18n Files in One or More Languages |
| [Exercise 4.2](#exercise-42---add-localized-string-formatter) | Add Localized String Formatter |
| [Exercise 4.3](#exercise-43---redeploy-the-application)      | Redeploy the Application                               |
| [Exercise 4.4](#exercise-44---update-the-mdk-app-with-new-metadata)      | Update the MDK App with New Metadata                   |

### Exercise 4.1 - Generate i18n Files in One or More Languages

1. Open your `MDKApp` project in VS Code. The project appears in the **Explorer**, and **Cline** is available in the Activity Bar on the left. Open the **Cline** panel.

   

2. In the Cline chat, ask Cline to generate the MDK i18n files, for example:

   > Generate MDK i18n files for multiple languages for this project.

   Cline uses the `mdk-gen` tool from the `mdk-mcp` server to produce the translation files. You can adjust the request to name specific languages if you like.

   

3. Review the proposed changes. Cline lists the generated language files and provides a **View Changes** button — inspect the files, then accept the changes to add them to your project.

   

   The generated i18n files are now available in the `i18n` folder of the project.

   


### Exercise 4.2 - Add Localized String Formatter

MDK supports various localization formatter functions, such as Localizable String, Number, Currency, Date, Time, and more. In this exercise, you will use a localization formatter to localize text, such as the `Incidents` page caption text available on the `Incident_List.page`.

1. Navigate to `Pages` &rarr; `Incident` &rarr; `Incident_List.page` to open it in the MDK page editor.

2. Click on the Action Bar area (as highlighted in the screenshot) to access the page caption property.

   

3. Click the **link** icon for the **Caption** property. Select **i18n Objects** from the dropdown and double-click on `Incidents:"Incidents"` to bind the page caption to a localizable string. The resulting expression is `$(L,'Incidents')`.

   

   You may similarly set localized strings for other texts in your project.

### Exercise 4.3 - Redeploy the Application

Now that you have generated the localization files, it is time to deploy the changes to see the result.

1. With a `.page` (or `.app`) file open, click the blue **Deploy** button in the **MDK Page Editor toolbar** (top-right) to deploy your changes to Mobile Services.

   

   > **Tip:** If the organization list is empty when you pick **Mobile Services** during Deploy, the CLI target was not set during the sign-in step. Open a VS Code terminal, run `cf target -o ad265 -s dev`, then retry the deployment.

### Exercise 4.4 - Update the MDK App with New Metadata

| Steps | Android | iOS |
|---|---|---|
| 1. Tap the **Check for Updates** option in the `User menu` on the Incident page. |  |  |
| 2. You will see a `New Version Available!` pop-up. Tap **Now**. |  |  |
| 3. To test localized string changes, change the device language to one of the following: <br> &#9702; Chinese <br> &#9702; Dutch <br> &#9702; French <br> &#9702; German <br> &#9702; Italian <br> &#9702; Japanese <br> &#9702; Spanish <br><br> Relaunch the MDK client to see the localized strings, e.g. the `Incidents` list caption. <br><br> *Note: The **New** screenshot below was taken with the device language set to **German** (`Incidents` → `Vorfälle`).* |  | *Previous:* <br>  |

## Summary

You have learned how to generate translation files using the agentic AI capabilities of Cline together with the MDK MCP Server. You can further extend your project by asking Cline to generate additional pages and actions.

## Navigation

| Previous | Next |
| --- | --- |
| [Exercise 3](../ex3/README.md) | [Conclusion](../../Conclusion.md) |
