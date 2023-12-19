# Steel Inflation Index (SII) Run
Since November 2023, the Leviat D&A DevOps team has taken over responsibility for updating, refreshing and publishing the monthly Steel Inflation Index report. The following section will explain the basic steps to complete the process, and answer FAQ's.

#### Timeline
The timeline for the SII run varies depending on the delivery of the files, but has general guidelines to manage expectations:
- `Preparation` | 1st - 7th  -> Judy Geng is responsible to collect, organize and deliver the source files.
- `Execution`   | 7th - 9th  -> The D&A Team is responsible to refresh the SII, and resolve any issues with Judy.
- `Reporting`   | 9th - 10th -> The report is verified by Judy and published to D&A Procurement. Judy reports to the end-users.

#### Executing the SII Run
The SII run is simple, and consists of a few standardized steps.
1. Collect the files from the Leviat CPI Package of the applicable month. 
    - The files are stored on the Leviat Data and Analytics Platform/007_Procurement/Steel Inflation Index/Files.
    - Each month should contain the 4 regional files. Any other files such as Beroe forecast are optional.

1. Update the dataset with the latest data.
    - Take the latest available version of the SII from D&A Procurement.
    - Go to "Transform Data" in PowerBI.
    - Under Raw [6], change the source path of the four received files to the new files.
    - Optional: Update any other new files received in their relative PowerQuery steps.

1. Update the Report.
    - Change the title of the Report to the applicable time period. (E.G.: 2023 NOVEMBER)
    - Update the reader's note (*) to report the date at which the refresh is done. (E.G.: *08-12-23: All regions are updated and forecasting has been updated till 2024-12.)
    - Update the Date Selection in the slicer panel to the applicable month. (E.G.: 2023-11)
    - On each of the visuals, update the X-Axis constant line to the 1st of the applicable period. (E.G.: 01-11-2023)

1. Publish and confirm.
    - Verify the report on Procurement_QAS with Judy. 
    - On confirmation, publish to Procurement, update the app and  confirm to Judy. 
    - Judy will create a standardized slide deck and confirm to all end-users that the update is succesful and available.

#### FAQ's
The following section will briefly elaborate on some of the most frequest issues that may arise.

1. I get an error during the refresh after changing the file, there is an issue with the underlying data. How do I resolve this
    - Most likely an error has been made during the forecasting. Reach out to Judy Geng to have the underlying files adjusted accordingly.

2. The files are not yet available on the 7th, what do I do?
    - Confirm with Judy when the files are available. Judy should communicate any delays in the process to the end-user base.

3. The reported values are significantly different from the previous months' run. What do I do?
    - As the files are a manual input of confirmed and forecasted values, a small variance Month-over-month is expected. Any change between 1 and 10% is accepted and expected. Changes > 10% need to be confirmed with Judy. 