<!-- Generated from the AD265 instructions repo (ex2/README.md); images stripped. Do not hand-edit — re-run .gen-readmes.sh. -->

# Exercise 2 - Enhance the generated Incidents List and Detail pages

## Estimated time

:clock4: 20 minutes

## Objective

In this exercise, you'll add a Profile Header UI control to the Incident detail page to provide end users with access to communicate with a customer.

| Exercise Number   | Title                                                 |
|-------------------|-------------------------------------------------------|
| [Exercise 2.1](#exercise-21---replace-the-existing-object-header-with-profile-header-ui-control)      | Replace the Existing Object Header with Profile Header UI Control  |
| [Exercise 2.2](#exercise-22---redeploy-the-application)      | Redeploy the Application  |
| [Exercise 2.3](#exercise-23---update-the-mdk-app-with-new-metadata)      | Update the MDK App with New Metadata  |

### Exercise 2.1 - Replace the Existing Object Header with Profile Header UI Control

A Profile header UI control provides additional information and enhances access to various communication methods with a customer.

1. Navigate to `Pages` &rarr; `Incident` &rarr; `Incident_Detail.page`. Update the page's `DesignTimeTarget`'s `QueryOptions` to access Customer information at design time. Click on the three-dot icons to open the Object Browser for the `QueryOptions` property.

    

    >The `DesignTimeTarget` property is similar to Target, but is only used for design time. This allows the Object Browser to show a filtered list based on the Design Time Target rather than the full list of all Entities.

2. Select the `customer` expand property. You'll notice that the expression value updates accordingly. Click **OK** to close the Query Options Expression Editor. You can now access and bind customer information to any control on the detail page.

       

3. Now, you will add the **Profile Header** control to display information such as name, location, and communication methods with a customer. <br/> In the Layout Editor, expand the **Controls** &rarr; **Static Container** group, then drag and drop the **Profile Header** control onto the top of the page area.

    

4. In the **Properties** pane under **Appearance**, clear the default value for the `Description` property. 

5. For the `DetailImage` property, click on the link icon to open the Object Browser, search for the `customer` SAP icon and double-click on it. 

    

6. For the `Headline` property, click on the link icon to open the Object Browser and bind to Customer's first and last name.

     > Ensure that `OData Objects` is selected in the dropdown menu.

    - In the search field, look for `first`, select `FirstName` and **double-click on it**. The binding `{customer/FirstName}` will be generated in the expression box. **Do not close the Object Browser window**.
    - Add a space after the generated value.
    - Look for `last` in the search field, select `LastName` and **click on `Insert`**. You'll notice the binding `{customer/FirstName} {customer/LastName}` generated in the expression box. 
    - Click **OK** to set the value to the control field.

    

7. Repeat the same steps for the `Subheadline` property, binding it to the customer's city and country values `{customer/AddressCity} {customer/AddressCountry}`. 

    

8. Under the `ActivityItems` section in the Properties pane, click **Add** to create a new activity item.

    

9. Expand the newly added item, then click the three-dot icon for the `ActivityValue` to open the Object Browser. Bind the `Phone` property of the Customer entity.

    

10. Add two more activity items in a similar manner for Email and Message, and bind them to the customer's Email and Phone properties.

    

11. Save your changes manually. (**File** &rarr; **Save** or `Ctrl+S`). 


### Exercise 2.2 - Redeploy the Application

Now that you have completed the changes to the Incident Detail page, it's time to deploy the changes and see the result.

With the page open in the MDK Page Editor, click the blue **Deploy** button in the Page Editor toolbar (top-right of the editor) to deploy your changes to Mobile Services.



>You are already signed in to Cloud Foundry from Exercise 1, so the deployment reuses your existing target (`ad265` / `dev`) and app. If you are prompted to sign in again, follow the Cloud Foundry sign-in steps from [Exercise 1.3](../ex1/README.md#exercise-13---deploy-the-application).


### Exercise 2.3 - Update the MDK App with New Metadata

| Steps | Android | iOS |
|---|---|---|
| 1. Tap the **Check for Updates** option in the `User menu` on the Incidents page. |  |  |
| 2. You will see a `New Version Available!` pop-up. Tap **Now**. |  |  |
| 3. On the Detail page, a profile header will display the customer's details and communication items. This will allow you to email, make a phone call, or send a message to the customer. |  |  |

## Summary

You've enhanced the incident detail page to better suit the technician. They can now quickly view customer contact details and reach out directly from the app.

## Navigation

| Previous| Next |
|---|---|
| [Exercise 1](../ex1/README.md) | [Exercise 3](../ex3/README.md) |
