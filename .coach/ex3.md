<!-- Generated from the AD265 instructions repo (ex3/README.md); images stripped. Do not hand-edit — re-run .gen-readmes.sh. -->

# Exercise 3 - Modify an Incident Record

## Estimated Time

:clock4: 40 minutes

## Objective

Incidents are assigned to a technician by a call center support representative. At the start of their day, the technician commences work on these incidents while at the customer's location.

- If the status of an incident is `New`, the technician can update it to `In Process`.
- The technician can also update the status to `Closed` after resolving the customer's issue.
- To close an incident, a technician must:
    - Update the ID of the defective device either by manually entering the code or scanning the device's barcode.
    - Upload a photograph of the working device.
    - Acquire the digital signature of the customer confirming that the issue has been resolved.
- If an incident's status is already `Closed`, the technician will not see any option to modify the details. They have the ability to view its details and open the working device's image.

| Exercise Number   | Title                                                 |
|-------------------|-------------------------------------------------------|
| [Exercise 3.1](#exercise-31---add-ui-controls-in-a-page-for-modifying-incident-information)      | Add UI Controls in a Page for Modifying Incident Information  |
| [Exercise 3.2](#exercise-32---store-the-updated-data-locally)      | Store the Updated Data Locally                        |
| [Exercise 3.3](#exercise-33---validate-inputs-before-saving-incident-entity)      | Validate Inputs before Saving Incident Entity   |
| [Exercise 3.4](#exercise-34---restrict-edit-button-visibility-based-on-incident-status)      | Restrict Edit Button Visibility Based on Incident Status                     |
| [Exercise 3.5](#exercise-35---redeploy-the-application)      | Redeploy the Application                               |
| [Exercise 3.6](#exercise-36---update-the-mdk-app-with-new-metadata)      | Update the MDK App with New Metadata                   |


### Exercise 3.1 - Add UI Controls in a Page for Modifying Incident Information

Both online and offline applications can be modified by users. Online application changes are saved to the backend immediately, while offline applications store the changes locally until they are synced to the backend using an Upload action.

In this step, you'll add fields editable by a technician, including status, ID of the defective device, device image, and customer signature on a page. This page will display a subset of items from the Incident Detail page.

1. Expand the `Pages` &rarr; `Incident`, and click on the `Incident_Edit.page` to open it with the **Page Editor**.



2. In the Layout Editor, expand the **Static Container** group. Drag and drop **Form Cell** onto the Page area.

    

3. You will now add Form Cell controls to the Form Cell section. Expand the **Form Cell Controls** group, drag and drop a **List Picker** onto the Form Cell section in the page area.

    

4. Provide the following information:

    | Property | Value |
    |----|----|
    | `Name`| `FCStatus` |
    | `Caption` | `Status` |
    | `AllowEmptySelection` | Choose `false` from the dropdown |
    | `AllowMultipleSelection` | Choose `false` from the dropdown |
    | `IsPickerDismissedOnSelection` | Choose `true` from the dropdown |
    | `RequiredIndicator` | Delete the default value and enter `true` |  

    

    >- `AllowEmptySelection:` This disables or enables the selection of empty value set.
    >- `AllowMultipleSelection:` This disables or enables the selection of multiple values from the list.
    >- `IsPickerDismissedOnSelection:` This enables automatic dismissal of the list view after an entry is selected.
    
5. When a technician is updating the status of an incident, they should be presented with specific options depending on the current status of the incident.
   - If the current status is `New` or `In Process`, the technician should see the options `In Process` and `Closed`.
   - In the **Properties** pane, for the `PickerItems` property, provide the values as `In Process` and `Closed` for `item0` and `item1` respectively. Click the `item2` and then click the trash icon to delete it.

    

6. When updating an incident, the current status will be visible on the list picker.
    - If the current status is `New`, the value will be blank. This is because it wouldn't make sense for them to update the status to `New` again; instead, they would likely choose either `In Process` or `Closed`.
    - If the current status is `In Process`, the technician has two options:
        - They can leave the default value as `In Process`, update the device ID, and continue working on the assigned incident.
        - They can change the status to `Closed` and provide all the necessary information to close the incident.
    - Click on the link icon to open the Object Browser for the **Value** property. Select **OData Objects** in the dropdown menu. In the search field, look for status, select `Status` and double-click on it. Click **OK**.

    

7. Update the default value for `PlaceHolder` to **Select Status**. 

    

8. Below the list picker control on the Form Cell section of the `Incident_Edit.page` area, drag and drop a **Simple Property** Form Cell control. This allows a technician to manually input or scan the ID of the defective device.

    

9. Provide the following information:

    | Property | Value |
    |----|----|
    | `Name`| `FCDeviceID` |
    | `Caption` | `Device ID` |
    | `RequiredIndicator` | Delete the default value and enter `true` |  
    | `AlternateInput` | Choose `Barcode` from the dropdown |
    | `Value` | Click on the link icon to open the Object Browser and bind it to the `Device ID` |
    | `PlaceHolder`  | Enter `Type in the device's ID or scan its barcode` |

    

10. Below the simple property control on the Form Cell section of the `Incident_Edit.page` area, drag and drop an **Attachment** Form Cell control. This allows a technician to upload an image of the device they have repaired.  

    

11. Provide the following information:          

    | Property | Value |
    |----|----|
    | `Name` | `FCDeviceImage` |
    | `IsVisible` | `false` |
    | `MaxAttachments` | 1 |
    | `RequiredIndicator` | Delete the default value and enter `true` |  
    | `AttachmentActionType` | Unselect `SelectFile` option |
    | `AttachmentAddTitle` | `Add` |
    | `AttachmentTitle` | `Device Image` | 

    

12. Below the attachment control on the Form Cell section of the `Incident_Edit.page` area, drag and drop an **Inline Signature Capture** Form Cell control. This enables a technician to collect a digital signature from the customer to confirm that the issue has been resolved.

    

13. Provide the following information:          

    | Property | Value |
    |----|----|
    | `Name` | `FCCustomerSignature` |
    | `Caption` | `Customer Signature` |
    | `ShowTimestampInImage` | Choose `true` option from the dropdown |
    | `TimestampFormatter` | `YYYY-MM-dd 'at' HH:mm:ss` |
    | `WatermarkText` | `Signed by {customer/FirstName} {customer/LastName}` | 
    | `IsVisible` | `false` |
    | `RequiredIndicator` | Delete the default value and enter `true` |  

    

    >- `ShowTimestampInImage:` The datetime will be displayed in the captured signature image.
    >- `TimestampFormatter:` Set a DateTime format pattern string for the timestamp on the captured signature image.
    >- `WatermarkText:` The watermark text will be displayed in the captured signature image.

14. If the `In Process` option is chosen from the Status list picker during an Incident modification, the options for uploading a Device Image and capturing customer signature should be hidden. However, if the `Closed` status is selected, the technician should be provided with options to upload an image of the device and collect the customer's signature. This logic needs to be added to the `Incident_Edit.page` in the application.

    Select `Status` List Picker control, navigate to the **Event** tab, click on **Create a rule/action** for `OnValueChange` event.

    

15. Next, select **Object Type** as **Rule** and **Folders** as `/MDKApp/Rules/Incident`. Click **OK**. This keeps all related files organized together.

    

16. Provide the name `StatusChangeProtocol` to your rule, click **Finish**.

    

17. Replace the generated snippet with the following code.

    ```JavaScript
    /**
    * Describe this function...
    * @param {IClientAPI} clientAPI
    */
    export default function StatusChangeProtocol(clientAPI) {
        //Get the Sectioned Table based on the name
        const sectionedTable = clientAPI.getPageProxy().getControl('SectionedTable0');
        //Get the section based on the name
        const fcsection = sectionedTable.getSection('SectionFormCell0');
        //Get the control based on the name
        const fcAttachment = fcsection.getControl('FCDeviceImage');
        const fcSignatureCapture = fcsection.getControl('FCCustomerSignature');
        const selectedValue = clientAPI.getValue()[0].ReturnValue;
        if (selectedValue == "In Process") {
            fcAttachment.setVisible(false);
            fcSignatureCapture.setVisible(false);
        } else if (selectedValue == "Closed") {
            fcAttachment.setVisible(true);
            fcSignatureCapture.setVisible(true);
        }
    }
    ```

18. Save all files. (**File** &rarr; **Save All** or `Ctrl+S`).


### Exercise 3.2 - Store the Updated Data Locally

While a technician is updating incident information, such as Status, Device ID, Device Image, and Customer Signature, these details will be communicated to the backend through relevant OData calls based on entity type and their respective OData property types.

You can find details of the service definition in your MDK metadata project `/Services/.IncidentManagement.xml`.
    


To update the `Status` and `DeviceID` properties of the Incident entity, the OData Update Entity action is used. <br/> However, when dealing with the `DeviceImage` and `ResolutionSignatureImage` properties of the Incident entity, which are of type Edm.Stream, the OData UploadStream action is used. Stream properties are used to store binary data, such as images or files. 

- You will now add an Action Bar item on the `Incident_Edit.page`. This item will trigger an OData Update Entity action to save the Status and Device ID.
- Following the successful completion of the OData Update Entity action, you will initiate an OData Upload Stream action to save the Device Image and Customer Signature.
- Once the update actions are executed successfully, close the Edit page.
- A failure message should be displayed if either action fails to execute the changes.

1. In the `Incident_Edit.page`, **drag and drop** an **Action Bar Item** to the upper right corner of the action bar.

    

2. In the Properties pane, provide the following information:        

    | Property | Value |
    |----|----|
    | `Caption` | `Save` |
    | `SystemItem` | Click the **link icon** to open the Object Browser, double-click the **Save** type and click **OK**. |

    

3. Navigate to the **Events** tab. Click the three-dot icon for the `OnPress` property and select the `Create a rule/action`.

    

4. Set the selection for the `Object Type` as **Action** and `Folders` path as `/MDKApp/Actions/Incident`. This keeps all related files organized together.

       

5. In the search **Category** dropdown, choose **Data** | click **OData** | click **Next**.

       

6. In the **Base Information** step, provide the following information and click **Next**.

    | Property | Value |
    |----|----|
    | `Name`| `Incident_UpdateEntity` |
    | `Type` | Select `UpdateEntity` from the dropdown |
    | `Service`| Select `IncidentManagement.service` from the dropdown |
    | `EntitySet`| Select `Incident` from the dropdown |
    | `ReadLink`| Click link icon to open the Object Browser and double-click `readLink` |

      

    >The `readLink` is a direct reference to an individual entity set entry.

7.  In the **Property and Update Links** step, uncheck **ID**.

8.  You will bind `Status` and `DeviceID` OData properties to respective UI Controls. 
    - Select the `Status` property and click the **link icon** to open the Object Browser. 
    - In the Object Browser, change the dropdown to `Control & ClientData`, and select the **Current Page** radio button.
    - In the search box, start typing `status`. The list will filter to display the matching values. Double-click the **SelectedValue (Value)** entry under the `FCStatus` field and click **OK** to set binding.

      

    >`SelectedValue` provides the return value of List Picker selection.

9. Repeat the above step for DeviceID.
    - Select the `DeviceID` property and click the **link icon** to open the Object Browser. 
    - Change the drop-down in the Object Browser to `Control & ClientData`, click the **Current Page** radio button.
    - In the search box, start typing `device`. The list will filter down to show the matching values. Double-click the **Value (Value)** entry under the `FCDeviceID` field and click **OK** to set binding.

     

10. Click **Finish**. The action editor will open with the `Incident_UpdateEntity.action` loaded.

11. When this `Incident_UpdateEntity.action` fails for any reason, you may want to display an error. In the `Incident_UpdateEntity.action`, scroll down and expand the **Common Action Properties** section. Click on the link icon for `Failure Action` property to open the Object Browser and bind to an existing message action `GenericMessageBox.action`.

     

12. You will now override this action's properties and define some specific information about `Incident_UpdateEntity.action`. Click on the override icon to open the override action properties wizard. 

     

13. Provide the following information and then click **OK**.

    | Property | Value |
    |----|----|
    | `Message` | `Update entity failure - {#ActionResults:Incident_UpdateEntity/error}` |
    | `Title` | `Update Incident` |

     

    >`Incident_UpdateEntity` is the Action Result value of the Incident_UpdateEntity.action. This reference is used to pass the results to subsequent actions in the chain. These actions can reference the action result as needed. In this case, if there is a failure, you access the error property of the action result to display the OData failure message. <br/> This is the standard Binding Target Path (also called Dynamic Target Path) syntax used when you need to include a binding with other bindings or within a string as used in the message here.<br/> You could exclude the above expression and can just display a generic message.

14. Upon successful completion of the `Incident_UpdateEntity.action`, an OData Upload Stream action should be initiated to save the Device Image and Customer Signature. <br/> Click the `Create a rule/action` icon for the **Success Action**. 

     

15. Select **Object Type** as **Action** and `Folders` as `/MDKApp/Actions/Incident`. Click **OK**.

       

16. In the search **Category** dropdown, choose **Data** | click **Media** | click **Next**. 

      

17. In the **Base Information** step, provide the following information and click **Next**.

    | Property | Value |
    |----|----|
    | `Name`| `Incident_UploadStream` |
    | `Type` | Select `UploadStream` from the dropdown |
    | `Service`| Select `IncidentManagement.service` from the dropdown |
    | `EntitySet`| Select `Incident` from the dropdown |
    | `ReadLink`| Click link icon to open the Object Browser and double-click `readLink` |

     

18.  In the **Property and Update Links** step, select the `DeviceImage` property and click the **link icon** to open the Object Browser.
    -  Change the drop-down in the Object Browser to `Control & ClientData`, select the **Current Page** radio button.
    - In the search box, start typing `image`. The list will filter to display the matching values. Double-click the **Value (Value)** entry under the `FCDeviceImage` field and click **OK** to set binding.

         

19. Select the `ResolutionSignatureImage` property and click the **link icon** to open the Object Browser.
    -  Change the drop-down in the Object Browser to `Control & ClientData`, select the **Current Page** radio button.
    - In the search box, start typing `signature`. The list will filter to display the matching values. Double-click the **Value (Value)** entry under the `FCCustomerSignature` field and click **OK** to set binding.
    
         

20. Click **Finish**. The action editor will open with the `Incident_UploadStream.action` loaded.

21. When the `Incident_UploadStream.action` is executed, you may want to display a success message and close the page. When it fails for any reason, you may want to display an error. <br/> In the `Incident_UploadStream.action`, scroll down and expand the **Common Action Properties** section. Click on the link icon for `Success Action` property to open the Object Browser and bind to an existing message action `GenericToastMessage.action`.

     

22. You will now override this action's properties and define some specific information about handling `Incident_UploadStream.action`. Click on the override icon to open the override action properties wizard. 

     

23. Provide the following information and then click **OK**.

    | Property | Value |
    |----|----|
    | `Message` | `Entity updated` |
    | `Duration` | `2` |
    | `Animated` | Select `true` from the dropdown option |
    | `Common Action Properties` &rarr; `Success Action` | Click on the link icon and bind it to `CloseModalPage_Complete.action` |

     

24. When this `Incident_UploadStream.action` fails for any reason, you may want to display an error. Click on the link icon for `Failure Action` property to open the Object Browser and bind to an existing message action `GenericMessageBox.action`.

     

25. You will now override this action's properties and define some specific information when `Incident_UploadStream.action` fails. Click on the override icon to open the override action properties wizard. 

     

26. Provide the following information and then click **OK**.

    | Property | Value |
    |----|----|
    | `Message` | `Upload Stream failure - {#ActionResults:Incident_UploadStream/error}` |
    | `Title` | `Upload Stream` |

     

27. Save all files. (**File** &rarr; **Save All** or `Ctrl+S`).

### Exercise 3.3 - Validate Inputs before Saving Incident Entity

Ensure the technician can only save an incident entity after providing all the required inputs. If they don't, show them an appropriate message. For instance, if they try to submit a record with an empty status, no Device ID, or without a customer signature, they should be prompted with a warning message.

To achieve this, you'll need to implement business logic that validates the input values. This logic needs to be bound to the `Save` ActionBar item on the `Incident_Edit.page`.

1. In `Incident_Edit.page`, select the `Save` ActionBar item and navigate to the **Events** tab. Clear the existing binding for the `OnPress` property.

     

2. Click the three-dot icon for the `OnPress` property, and select `Create a rule/action`.

     

3. Select **Object Type** as **Rule** and **Folders** as `/MDKApp/Rules/Incident`. Click **OK**.  

    

4. Provide the name `Incident_ValidateEdit` to your rule, and then click **Finish**.

      

5. Replace the generated snippet with the following code.

    ```JavaScript
    /**
    * Describe this function...
    * @param {IClientAPI} clientAPI
    */
    export default function Incident_ValidateEdit(clientAPI) {
        var attachments = clientAPI.getPageProxy().getControl('SectionedTable0').getSection('SectionFormCell0').getControl('FCDeviceImage').getValue();
        var statusPicker = clientAPI.getPageProxy().getControl('SectionedTable0').getSection('SectionFormCell0').getControl('FCStatus').getValue();
        var currentStatus;
        if (statusPicker.length > 0 && statusPicker[0].ReturnValue) {
            currentStatus = statusPicker[0].ReturnValue;
        }
        var customerSignature = clientAPI.getPageProxy().getControl('SectionedTable0').getSection('SectionFormCell0').getControl('FCCustomerSignature').getValue();
        var deviceID = clientAPI.getPageProxy().getControl('SectionedTable0').getSection('SectionFormCell0').getControl('FCDeviceID').getValue();
        if (!currentStatus) {
            return clientAPI.executeAction({
                "Name": '/MDKApp/Actions/GenericMessageBox.action',
                "Properties": {
                    "Message": "Please select status",
                    "Title": "Validation"
                }
            })
        }
        if (!deviceID) {
            return clientAPI.executeAction({
                "Name": '/MDKApp/Actions/GenericMessageBox.action',
                "Properties": {
                    "Message": "Device ID is required",
                    "Title": "Validation"
                }
            })
        }
        if (currentStatus === "Closed" && attachments.length !== 1) {
            return clientAPI.executeAction({
                "Name": '/MDKApp/Actions/GenericMessageBox.action',
                "Properties": {
                    "Message": attachments.length < 1 ? "Please add 1 device image" : "Max. 1 image allowed for the device",
                    "Title": "Validation"
                }
            })
        }
        if (currentStatus === "Closed" && !customerSignature) {
            return clientAPI.executeAction({
                "Name": '/MDKApp/Actions/GenericMessageBox.action',
                "Properties": {
                    "Message": "Customer Signature is required",
                    "Title": "Validation"
                }
            })
        }
        return clientAPI.executeAction({
            "Name": '/MDKApp/Actions/Incident/Incident_UpdateEntity.action',
            "Properties": {
                "OnSuccess": currentStatus === "Closed" ? "/MDKApp/Actions/Incident/Incident_UploadStream.action" : "/MDKApp/Actions/CloseModalPage_Complete.action"
            }
        })
    }
    ```

6. Save all files. (**File** &rarr; **Save All** or `Ctrl+S`).

### Exercise 3.4 - Restrict Edit Button Visibility Based on Incident Status  

The **Edit** button on the Incident Detail page should be visible **only** for incidents that are in the `New` or `In Process` state. If an incident's status is `Closed`, the technician should not be able to modify any details. This behavior should be integrated into your application logic.  

1. In `Incident_Detail.page`, click on `Create a rule` icon for the **Visible** property of **Edit** action bar item.

       

2. Select **Object Type** as **Rule** and **Folders** as `/MDKApp/Rules/Incident`. Click **OK**.  

    


3. Provide the name `EditOptionVisibility` to your rule, and then click **Finish**.

      

4. Replace the generated snippet with the following code.

    ```JavaScript
    /**
    * Describe this function...
    * @param {IClientAPI} clientAPI
    */
    export default function EditOptionVisibility(clientAPI) {
        let currentStatus = clientAPI.binding.Status;
        if (currentStatus == "Closed") {
            return false;
        }
        else {
            return true;
        }
    }
    ```

5. Save all files. (**File** &rarr; **Save All** or `Ctrl+S`).

### Exercise 3.5 - Redeploy the Application

Now that you have created the Edit page, it is time to deploy the changes to see the result.

With the page open in the MDK Page Editor, click the blue **Deploy** button in the Page Editor toolbar (top-right of the editor) to deploy your changes to Mobile Services.



>You are already signed in to Cloud Foundry from Exercise 1, so the deployment reuses your existing target (`ad265` / `dev`) and app. If you are prompted to sign in again, follow the Cloud Foundry sign-in steps from [Exercise 1.3](../ex1/README.md#exercise-13---deploy-the-application).


### Exercise 3.6 - Update the MDK App with New Metadata

| Steps | Android | iOS |
|---|---|---|
| 1. Tap the **Check for Updates** option in the `User menu` on the Incident page.| | |
| 2. You will see a `New Version Available!` pop-up. Tap **Now**.| | |
| 3. Navigate to an Incident detail page. <br/><br/> If an incident's status is already `Closed`, you will not see the **Edit** option in the action bar. Instead, you will have the ability to open the working device's image. <br/><br/>  If an incident's status is `New` or `In Process`, you will see the **Edit** option.| | |
| 4. Update an Incident. <br/><br/> You can update the status from `New` to `In Process` or `Closed` or from `In Process` to `Closed`. <br/><br/> When updating it to `In Process`, you should be able to enter the ID of the defective device, either by manually typing it or scanning the device's barcode, but you won't have options for uploading a device image or capturing the customer's signature. <br/><br/> When updating it to `Closed`, you should be able to enter the ID of the defective device, either by manually typing it or scanning the device's barcode, and you should also see the options for uploading a device image and capturing the customer's signature. <br/><br/> To scan the device's barcode, you can use the below image. <br/><br/><br/><br/>  | | |
| 5. Since this is an Offline application, the changes are saved to the local store, which needs to be sent or uploaded to the backend explicitly. <br/><br/> Navigate to the Incident list page, pull down on the incident list to upload changes to the backend, OR click on the user menu icon and select **Sync Changes**. You should see a `Sync Completed` message displayed. |  | |

## Summary

You've now successfully modified an incident entity. 

## Navigation

| Previous| Next |
|---|---|
| [Exercise 2](../ex2/README.md) | [Exercise 4](../ex4/README.md) |
