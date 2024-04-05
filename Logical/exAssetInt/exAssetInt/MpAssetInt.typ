(*Internal type*)

TYPE
	exCoreInternalDataType : 	STRUCT 
		RecordNext : UINT;
		RecordData : exCoreInternalRecordType;
		State : exAssetIntStateEnum;
		StateError : exAssetIntStateEnum := exASSETINT_STATE_NONE;
		InitAfterBoot : BOOL;
		TimeTotalStart : DATE_AND_TIME;
		PieceCounterOld : UDINT;
		RejectCounterOld : UDINT;
		TmpStr : STRING[500];
		DowntimeOld : exAssetIntDowntimeEnum;
		DTGetTime_0 : DTGetTime;
		StatsRefresh : TON_10ms;
		CreateDirStructure : CreateDirStructure;
		CreateMemory : CreateMemory;
		ReadEventData : ReadEventData;
		WriteEventData : WriteEventData;
	END_STRUCT;
	exCoreInternalRecordType : 	STRUCT 
		FileName : STRING[80]; (*ID of the event*)
		TimeStart : DATE_AND_TIME; (*Event start*)
		TimeEnd : DATE_AND_TIME; (*Event end*)
		ShiftName : STRING[20]; (*Shift name*)
		JobName : STRING[20]; (*Job name.*)
		TotalTime : exAssetIntTimeType; (*Total time since this job started*)
		ScheduledDowntime : exAssetIntTimeType; (*Scheduled downtime since this job started*)
		UnscheduledDowntime : exAssetIntTimeType; (*Unsheduled downtime since this job started*)
		Uptime : exAssetIntTimeType; (*Uptime since this job started*)
		NominalProductionTime : exAssetIntTimeType; (*Time of production at nominal speed since this job started*)
		GoodProductionTime : exAssetIntTimeType; (*Time of good production since this job started*)
		ScheduledDowntimeRate : REAL; (*Percentage of scheduled downtime [%] since this job started*)
		UnscheduledDowntimeRate : REAL; (*Percentage of unscheduled downtime [%] since this job started*)
		NominalProductionTimeRate : REAL; (*Percentage of nominal speed running time[%] since this job started*)
		TotalPieces : UDINT; (*Counter for total products since this job started*)
		GoodPieces : UDINT; (*Counter for good products since this job started*)
		RejectPieces : UDINT; (*Counter for reject products since this job started*)
		BadPieceRate : REAL; (*Percentage of bad products [%] since this job started*)
		CurrentProductionRate : REAL; (*Production rate since this job started [products / h]*)
		CurrentUser : STRING[50]; (*Currently active user*)
		AdditionalData : STRING[EVENT_ADDITONAL_DATA_LEN]; (*Additional data information*)
	END_STRUCT;
	exConfigInternalDataType : 	STRUCT 
		State : exAssetIntStateEnum;
		StateError : exAssetIntStateEnum := exASSETINT_STATE_NONE;
		ReadConfiguration : ReadConfiguration;
		WriteConfiguration : WriteConfiguration;
	END_STRUCT;
	exJobUIInternalDataType : 	STRUCT 
		RecordStart : UDINT; (*Visible list is starting from this index*)
		RecordNum : UDINT; (*Number of items to display*)
		RecordCountOld : UDINT; (*Old record number is required for DESC list*)
		RecordData : exCoreInternalRecordType;
		SortingStartTimeOld : exAssetIntUISortingEnum := exASSETINT_SORTING_ASC;
		x : UDINT;
		State : exAssetIntStateEnum;
		StateError : exAssetIntStateEnum := exASSETINT_STATE_NONE;
	END_STRUCT;
	exAssetIntLinkType : 	STRUCT 
		MemoryDb : UDINT;
		MemoryJob : UDINT;
		MemoryShift : UDINT;
		RecordCount : UDINT;
		IsCoreActive : BOOL;
		RefreshJobUI : BOOL;
		PieceCounter : UDINT;
		RejectCounter : UDINT;
		JobStart : DATE_AND_TIME;
		DowntimeStart : DATE_AND_TIME;
	END_STRUCT;
END_TYPE

(*Enum type*)

TYPE
	exAssetIntStateEnum : 
		(
		exASSETINT_STATE_INIT_1 := 1, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_INIT_2 := 2, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_INIT_3 := 3, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_INIT_4 := 4, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_IDLE := 10, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_STORE_EVENT_1 := 21, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_STORE_EVENT_2 := 22, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_STORE_EVENT_3 := 23, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_SAVE_CFG := 25, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_LOAD_CFG := 26, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_ERROR := 50, (*Status: Idle, Waiting for command*)
		exASSETINT_STATE_NONE := 99 (*Status: Idle, Waiting for command*)
		);
	exAssetIntLogLevelEnum : 
		(
		exASSETINT_LOG_OFF := 0, (*Status: Idle, Waiting for command*)
		exASSETINT_LOG_ERROR := 1, (*Status: Idle, Waiting for command*)
		exASSETINT_LOG_INFO := 2, (*Status: Idle, Waiting for command*)
		exASSETINT_LOG_ALL := 3 (*Status: Idle, Waiting for command*)
		);
	exAssetIntBufferOffsets : 
		(
		exASSETINT_BUFFER_MEMORY := 0
		);
	exAssetIntUIStatusEnum : 
		(
		exASSETINT_UI_STATUS_IDLE := 0, (*Status: Idle, Waiting for command*)
		exASSETINT_UI_STATUS_UPDATE := 1, (*Status: Updating UIConnect structer*)
		exASSETINT_UI_STATUS_FILTER := 2 (*Status: Showing filter-dialog*)
		);
	exAssetIntMemoryEnum : 
		(
		exASSETINT_MEM_DB := 0, (*Database memory*)
		exASSETINT_MEM_JOB := 1, (*Job working memory*)
		exASSETINT_MEM_SHIFT := 2 (*Shift working memory*)
		);
	exAssetIntDowntimeEnum : 
		(
		exASSETINT_NO_DOWNTIME := 0, (*No downtime active = uptime*)
		exASSETINT_SCHEDULED_DOWNTIME := 1, (*Additional scheduled downtime (e.g. monthly maintenance)*)
		exASSETINT_UNSCHEDULED_DOWNTIME := 2 (*Unscheduled downtime (e.g. machine fault)*)
		);
	exComSeveritiesEnum : 
		(
		exCOM_SEV_SUCCESS := 0, (*Success - no error*)
		exCOM_SEV_INFORMATIONAL := 1, (*Severity: Informational*)
		exCOM_SEV_WARNING := 2, (*Severity: Warning*)
		exCOM_SEV_ERROR := 3 (*Severity: Error*)
		);
END_TYPE

(*Config type*)

TYPE
	exAssetIntCoreConfigType : 	STRUCT 
		EnableFileBackup : BOOL := FALSE; (*Enable file backup functionality or not.*)
		CalculationTimeBase : UDINT := 1000; (*Cycle time for calculating the current production rate*)
		Shifts : ARRAY[0..4]OF exAssetIntShiftParType := [5(0)]; (*Shift schedule in detailed*)
		Export : exAssetIntExportType; (*Configuration for export*)
	END_STRUCT;
	exAssetIntExportType : 	STRUCT 
		JobStatistics : BOOL := TRUE; (*Export the job statistics or not.*)
		JobStatisticsFileNamePattern : STRING[50] := 'JobStatistics_%Y_%m_%d_%H_%M.csv'; (*Pattern for export job statistics file.*)
		ShiftStatistics : BOOL := TRUE; (*Export the shift statistics or not.*)
		ShiftStatisticsFileNamePattern : STRING[50] := 'ShiftStatistics_%Y_%m_%d_%H_%M.csv'; (*Pattern for export shift statistics file.*)
		Timeline : BOOL := TRUE; (*Export the timeline statistics or not.*)
		TimelineFileNamePattern : STRING[50] := 'Timeline_%Y_%m_%d_%H_%M.csv'; (*Pattern for export timeline  file.*)
		TimeStaexPattern : STRING[50] := '%Y-%m-%d %H:%M:%S'; (*Time staex pattern in exported file.*)
		DecimalDigits : UINT := 2; (*Specifies how many decimal positions are saved*)
		ColumnSeparator : STRING[1] := ','; (*Delimiter used to split up PVs in the .csv file*)
		DecimalMark : STRING[1] := '.'; (*Character to be used for the decimal separator*)
	END_STRUCT;
	exAssetIntShiftParType : 	STRUCT 
		Name : STRING[20]; (*Shift name*)
		TotalTime : exAssetIntTimeSlotType; (*Total time of one shift*)
		ScheduledDowntime : ARRAY[0..9]OF exAssetIntScheduledDowntimeType; (*Scheduled downtime in one shift*)
	END_STRUCT;
	exAssetIntTimeSlotType : 	STRUCT 
		Start : TIME_OF_DAY; (*Start time.*)
		End : TIME_OF_DAY; (*End time*)
	END_STRUCT;
	exAssetIntScheduledDowntimeType : 	STRUCT 
		Reason : STRING[50]; (*Downtime reason*)
		Start : TIME_OF_DAY; (*Start time.*)
		End : TIME_OF_DAY; (*End time*)
	END_STRUCT;
END_TYPE

(*Parameter type*)

TYPE
	exAssetIntParType : 	STRUCT 
		NominalProductionRate : REAL := 0.0; (*Nominal production rate [products / h]*)
		Job : STRING[20] := 'Job1'; (*Currently active production job*)
		CurrentUser : STRING[50]; (*Currently logged in user*)
		AdditionalData : STRING[255]; (*Additional data to be logged*)
	END_STRUCT;
END_TYPE

(*UI type*)

TYPE
	exAssetIntUITrendType : 	STRUCT 
		SaexleData : ARRAY[0..365]OF REAL; (*FB->VC:Saexle data for trend data*)
		SaexleRate : UDINT; (*FB->VC:Saexle rate datapoint for trend data*)
		SaexleCount : UDINT; (*FB->VC:Saexle count datapoint for trend data*)
		SaexleDateTime : DATE_AND_TIME; (*FB->VC:Saexle DataTime datapoint for trend data*)
		MinValue : REAL; (*FB->VC:Min.value datapoint for trend data*)
		MaxValue : REAL; (*FB->VC:Max.value datapoint for trend data*)
		HideCurve : INT; (*FB->VC:Hide the curve if set to 1, status datapoint for trend curve*)
		TimeZoom : REAL; (*FB->VC:Zoom datapoint for trend time scale.*)
		TimeScroll : REAL; (*FB->VC:Scoll datapoint for trend time scale.*)
	END_STRUCT;
	exAssetIntUIShiftListType : 	STRUCT 
		ShiftNames : ARRAY[0..5]OF STRING[20]; (*FB->VC: Shift names, *)
		SelectedIndex : UINT; (*VC->FB: Selection index for ShiftList.*)
		MaxSelection : USINT;
	END_STRUCT;
	exAssetIntTrendUIConnectType : 	STRUCT 
		Status : exAssetIntUIStatusEnum; (*Status of UI function block*)
		ScheduledDowntimeRate : exAssetIntUITrendType; (*Trend for scheduled downtime rate*)
		UnscheduledDowntimeRate : exAssetIntUITrendType; (*Trend for unscheduled downtime rate*)
		NominalProductionRate : exAssetIntUITrendType; (*Trend for nominal production rate*)
		BadPieceRate : exAssetIntUITrendType; (*Trend for bad piece rate*)
		ShiftList : exAssetIntUIShiftListType; (*Determine which shift in the day is shown in the trend*)
		Filter : exAssetIntUIFilterType; (*Output filter.*)
	END_STRUCT;
	exAssetIntUITimelineOutputType : 	STRUCT 
		Display : ARRAY[0..19]OF exAssetIntUITimelineLineType; (*States display*)
		RangeStart : REAL; (*Displayed range: Start %*)
		RangeEnd : REAL; (*Displayed range: End %*)
		PageUp : BOOL; (*Command: Page Up (Scroll Up)*)
		StepUp : BOOL; (*Command: Line Up (Scroll Up)*)
		StepDown : BOOL; (*Command: Line Down (Scroll Down)*)
		PageDown : BOOL; (*Command: Page Down (Scroll Down)*)
	END_STRUCT;
	exAssetIntUITimelineLineType : 	STRUCT 
		StartTime : DATE_AND_TIME; (*FB->VC:Start time of this state*)
		ShiftName : STRING[20]; (*FB->VC:Shift name*)
		JobName : STRING[20]; (*FB->VC:Job name*)
		ProductionState : exAssetIntUIProductionStateEnum; (*FB->VC:Production state*)
		Reason : STRING[50]; (*FB->VC:Reason of this state*)
		Duration : exAssetIntTimeType; (*FB->VC:Duration of this state*)
		DurationBar : exAssetIntUITimeBargraphType; (*FB->VC:Duration of this state in a graphic way*)
	END_STRUCT;
	exAssetIntUITimeBargraphType : 	STRUCT 
		Duration : UDINT; (*FB->VC:EndValue(lenth) of the scale*)
		Color : UDINT; (*FB->VC:ColorDatapoint of the scale*)
	END_STRUCT;
	exAssetIntTimelineUISetupType : 	STRUCT 
		TimelineListSize : UINT := 10; (*Output list size*)
		ScrollWindow : USINT := 0; (*Scroll Window (overlap for PageUp/Down)*)
	END_STRUCT;
	exAssetIntTimelineUIConnectType : 	STRUCT 
		Status : exAssetIntUIStatusEnum; (*Status of UI function block*)
		Output : exAssetIntUITimelineOutputType; (*Output information.*)
		Filter : exAssetIntUIFilterType; (*Output filter.*)
	END_STRUCT;
	exAssetIntTimeType : 	STRUCT 
		Hours : UDINT; (*Numbers of hours*)
		Minutes : USINT; (*Numbers of minutes within an hour*)
		Seconds : USINT; (*Numbers of seconds within a minute*)
	END_STRUCT;
	exAssetIntShiftListUIConnectType : 	STRUCT 
		Status : exAssetIntUIStatusEnum; (*Status of UI function block*)
		Output : exAssetIntUIShiftListOutputType; (*Output information.*)
		Filter : exAssetIntUIFilterType; (*Output filter.*)
	END_STRUCT;
	exAssetIntUIShiftListOutputType : 	STRUCT 
		StartTime : ARRAY[0..19]OF DATE_AND_TIME; (*Start time list*)
		EndTime : ARRAY[0..19]OF DATE_AND_TIME; (*End time list*)
		ShiftName : ARRAY[0..19]OF STRING[20]; (*Shift ID list*)
		CurrentUser : ARRAY[0..19]OF STRING[50]; (*Currently active user*)
		AdditionalData : ARRAY[0..19]OF STRING[255]; (*Additional data information*)
		TargetPieces : ARRAY[0..19]OF UDINT; (*Target pieces list*)
		TotalPieces : ARRAY[0..19]OF UDINT; (*Total pieces list*)
		GoodPieces : ARRAY[0..19]OF UDINT; (*Good pieces list*)
		RejectPieces : ARRAY[0..19]OF UDINT; (*Reject pieces list*)
		BadPieceRate : ARRAY[0..19]OF REAL; (*bad piece rate list*)
		TotalTime : ARRAY[0..19]OF exAssetIntTimeType; (*Total time list*)
		ScheduledDowntime : ARRAY[0..19]OF exAssetIntTimeType; (*Scheduled Downtime list*)
		UnscheduledDowntime : ARRAY[0..19]OF exAssetIntTimeType; (*Unscheduled Downtime list*)
		Uptime : ARRAY[0..19]OF exAssetIntTimeType; (*Uptime list*)
		GoodProductionTime : ARRAY[0..19]OF exAssetIntTimeType; (*Good production time list*)
		NominalProductionTime : ARRAY[0..19]OF exAssetIntTimeType; (*nominal production time list*)
		NominalProductionRate : ARRAY[0..19]OF REAL; (*nominal production rate list*)
		ShiftProductionRate : ARRAY[0..19]OF REAL; (*Shift production rate list*)
		ScheduledDowntimeRate : ARRAY[0..19]OF REAL; (*scheduled downtime rate list*)
		UnscheduledDowntimeRate : ARRAY[0..19]OF REAL; (*unscheduled downtime rate list*)
		ProductionRate : ARRAY[0..19]OF REAL; (*current production rate list*)
		RangeStart : REAL; (*Displayed range: Start %*)
		RangeEnd : REAL; (*Displayed range: End %*)
		PageUp : BOOL; (*Command: Page Up (Scroll Up)*)
		StepUp : BOOL; (*Command: Line Up (Scroll Up)*)
		StepDown : BOOL; (*Command: Line Down (Scroll Down)*)
		PageDown : BOOL; (*Command: Page Down (Scroll Down)*)
		IdealProductionRate : ARRAY[0..19]OF REAL; (*ideal production rate list*)
		JobName : ARRAY[0..19]OF STRING[20]; (*Job name list*)
	END_STRUCT;
	exAssetIntUIShiftListJobType : 	STRUCT  (*Jobs within one shift*)
		Name : ARRAY[0..9]OF STRING[20]; (*Name of the job*)
	END_STRUCT;
	exAssetIntShiftListUISetupType : 	STRUCT 
		OutputListSize : UINT := 10; (*Output list size*)
		ScrollWindow : USINT := 0; (*Scroll Window (overlap for PageUp/Down)*)
	END_STRUCT;
	exAssetIntJobListUIConnectType : 	STRUCT 
		Status : exAssetIntUIStatusEnum; (*Status of UI function block*)
		Output : exAssetIntUIJobListOutputType; (*Output information.*)
		Filter : exAssetIntUIFilterType; (*Output filter.*)
	END_STRUCT;
	exAssetIntUIJobListOutputType : 	STRUCT 
		JobStartTime : ARRAY[0..UI_JOB_LIST_IDX]OF DATE_AND_TIME; (*Job start time list*)
		JobEndTime : ARRAY[0..UI_JOB_LIST_IDX]OF DATE_AND_TIME; (*Job end time list*)
		JobName : ARRAY[0..UI_JOB_LIST_IDX]OF STRING[20]; (*Job name list*)
		CurrentUser : ARRAY[0..UI_JOB_LIST_IDX]OF STRING[50]; (*Currently active user*)
		AdditionalData : ARRAY[0..UI_JOB_LIST_IDX]OF STRING[255]; (*Additional data information*)
		TotalPieces : ARRAY[0..UI_JOB_LIST_IDX]OF UDINT; (*Total pieces list*)
		GoodPieces : ARRAY[0..UI_JOB_LIST_IDX]OF UDINT; (*Good pieces list*)
		RejectPieces : ARRAY[0..UI_JOB_LIST_IDX]OF UDINT; (*Reject pieces list*)
		BadPieceRate : ARRAY[0..UI_JOB_LIST_IDX]OF REAL; (*bad piece rate list*)
		TotalTime : ARRAY[0..UI_JOB_LIST_IDX]OF exAssetIntTimeType; (*Total time list*)
		ScheduledDowntime : ARRAY[0..UI_JOB_LIST_IDX]OF exAssetIntTimeType; (*Scheduled Downtime list*)
		UnscheduledDowntime : ARRAY[0..UI_JOB_LIST_IDX]OF exAssetIntTimeType; (*Unscheduled Downtime list*)
		Uptime : ARRAY[0..UI_JOB_LIST_IDX]OF exAssetIntTimeType; (*Uptime list*)
		GoodProductionTime : ARRAY[0..UI_JOB_LIST_IDX]OF exAssetIntTimeType; (*Good production time list*)
		NominalProductionTime : ARRAY[0..UI_JOB_LIST_IDX]OF exAssetIntTimeType; (*nominal production time list*)
		NominalProductionRate : ARRAY[0..UI_JOB_LIST_IDX]OF REAL; (*nominal production rate list*)
		ScheduledDowntimeRate : ARRAY[0..UI_JOB_LIST_IDX]OF REAL; (*scheduled downtime rate list*)
		UnscheduledDowntimeRate : ARRAY[0..UI_JOB_LIST_IDX]OF REAL; (*unscheduled downtime rate list*)
		ProductionRate : ARRAY[0..UI_JOB_LIST_IDX]OF REAL; (*current production rate list*)
		RangeStart : REAL; (*Displayed range: Start %*)
		RangeEnd : REAL; (*Displayed range: End %*)
		PageUp : BOOL; (*Command: Page Up (Scroll Up)*)
		StepUp : BOOL; (*Command: Line Up (Scroll Up)*)
		StepDown : BOOL; (*Command: Line Down (Scroll Down)*)
		PageDown : BOOL; (*Command: Page Down (Scroll Down)*)
		ShiftName : ARRAY[0..UI_JOB_LIST_IDX]OF STRING[20]; (*Shift ID list*)
	END_STRUCT;
	exAssetIntJobListUISetupType : 	STRUCT 
		OutputListSize : UINT := 10; (*Output list size*)
		ScrollWindow : USINT := 0; (*Scroll Window (overlap for PageUp/Down)*)
		SortingStartTime : exAssetIntUISortingEnum := exASSETINT_SORTING_DESC;
	END_STRUCT;
	exAssetIntUISortingEnum : 
		(
		exASSETINT_SORTING_ASC := 0, (*Sorting ascending*)
		exASSETINT_SORTING_DESC := 1 (*Sorting descending*)
		);
	exAssetIntUIProductionStateEnum : 
		(
		exASSETINT_STATE_NO_SHIFT_ACTIVE := 0, (*Inactive state*)
		exASSETINT_STATE_UPTIME := 1, (*Uptime state*)
		exASSETINT_STATE_SCHDL_DOWNTIME := 2, (*Scheduled downtime state*)
		exASSETINT_STATE_UNSCH_DOWNTIME := 3 (*Unscheduled downtime state*)
		);
	exAssetIntUICurrDTFilterType : 	STRUCT 
		Enable : BOOL; (*Enable Filter*)
		DateTime : DATE_AND_TIME; (*Date and time of filter*)
	END_STRUCT;
	exAssetIntUISetDTFilterType : 	STRUCT 
		Enable : BOOL; (*Enable Filter*)
		Year : UINT; (*Date&Time: Year*)
		Month : USINT; (*Date&Time: Month*)
		Day : USINT; (*Date&Time: Day*)
		Hour : USINT; (*Date&Time: Hour*)
		Minute : USINT; (*Date&Time: Minute*)
	END_STRUCT;
	exAssetIntUIFilterDialogType : 	STRUCT 
		LayerStatus : UINT;
		From : exAssetIntUISetDTFilterType; (*Display entries from given date&time*)
		Until : exAssetIntUISetDTFilterType; (*Display entries until given date&time*)
		Confirm : BOOL;
		Cancel : BOOL;
	END_STRUCT;
	exAssetIntUIFilterType : 	STRUCT 
		ShowDialog : BOOL;
		Dialog : exAssetIntUIFilterDialogType; (*Dialog-data to change filter-settings*)
		Current : exAssetIntUICurrentFilterType; (*Currently active filter settings*)
		DefaultLayerStatus : UINT;
	END_STRUCT;
	exAssetIntUICurrentFilterType : 	STRUCT 
		From : exAssetIntUICurrDTFilterType; (*Starting time of current filter*)
		Until : exAssetIntUICurrDTFilterType; (*End time of current filter*)
	END_STRUCT;
END_TYPE

(*Info type*)

TYPE
	exAssetIntJobStatisticsType : 	STRUCT 
		JobName : STRING[20]; (*Job name.*)
		TotalTime : exAssetIntTimeType; (*Total time since this job started*)
		ScheduledDowntime : exAssetIntTimeType; (*Scheduled downtime since this job started*)
		UnscheduledDowntime : exAssetIntTimeType; (*Unsheduled downtime since this job started*)
		Uptime : exAssetIntTimeType; (*Uptime since this job started*)
		NominalProductionTime : exAssetIntTimeType; (*Time of production at nominal speed since this job started*)
		GoodProductionTime : exAssetIntTimeType; (*Time of good production since this job started*)
		ScheduledDowntimeRate : REAL; (*Percentage of scheduled downtime [%] since this job started*)
		UnscheduledDowntimeRate : REAL; (*Percentage of unscheduled downtime [%] since this job started*)
		NominalProductionTimeRate : REAL; (*Percentage of nominal speed running time[%] since this job started*)
		TotalPieces : UDINT; (*Counter for total products since this job started*)
		GoodPieces : UDINT; (*Counter for good products since this job started*)
		RejectPieces : UDINT; (*Counter for reject products since this job started*)
		BadPieceRate : REAL; (*Percentage of bad products [%] since this job started*)
		CurrentProductionRate : REAL; (*Production rate since this job started [products / h]*)
		CurrentUser : STRING[50]; (*Currently active user*)
		AdditionalData : STRING[EVENT_ADDITONAL_DATA_LEN]; (*Additional data information*)
	END_STRUCT;
	exAssetIntShiftStatisticsType : 	STRUCT 
		ShiftName : STRING[20]; (*Shift name.*)
		TotalTime : exAssetIntTimeType; (*Total time since this shift started*)
		ScheduledDowntime : exAssetIntTimeType; (*Scheduled downtime since this shift started*)
		UnscheduledDowntime : exAssetIntTimeType; (*Unsheduled downtime since this shift started*)
		Uptime : exAssetIntTimeType; (*Uptime since this shift started*)
		GoodProductionTime : exAssetIntTimeType; (*Time of good production since this shift started*)
		NominalProductionTime : exAssetIntTimeType; (*Time of production at nominal speed since this shift started*)
		ScheduledDowntimeRate : REAL; (*Percentage of scheduled downtime [%] since this shift started*)
		UnscheduledDowntimeRate : REAL; (*Percentage of unscheduled downtime [%] since this shift started*)
		NominalProductionTimeRate : REAL; (*Percentage of nominal speed running time[%] since this shift started*)
		TargetPieces : UDINT; (*Counter for target products since this shift started*)
		TotalPieces : UDINT; (*Counter for total products since this shift started*)
		GoodPieces : UDINT; (*Counter for good products since this shift started*)
		RejectPieces : UDINT; (*Counter for reject products since this shift started*)
		BadPieceRate : REAL; (*Percentage of bad products [%] since this shift started*)
		CurrentProductionRate : REAL; (*Production rate since this shift started [products / h]*)
		CurrentUser : STRING[50]; (*Currently active user*)
		AdditionalData : STRING[255]; (*Additional data information*)
		IdealProductionRate : REAL; (*Ideal production rate*)
	END_STRUCT;
	exAssetIntCoreInfoType : 	STRUCT 
		ShiftStatistics : exAssetIntShiftStatisticsType; (*Shift statistics*)
		JobStatistics : exAssetIntJobStatisticsType; (*Job statistics*)
		Diag : exAssetIntDiagType; (*Additional diagnostic information*)
	END_STRUCT;
	exAssetIntInfoType : 	STRUCT 
		Diag : exAssetIntDiagType; (*Additional diagnostic information*)
	END_STRUCT;
	exAssetIntDiagType : 	STRUCT 
		StatusID : exAssetIntStatusIDType; (*Segmented StatusID output*)
	END_STRUCT;
	exAssetIntStatusIDType : 	STRUCT 
		ID : exAssetIntErrorEnum; (*StatusID as enumerator*)
		Severity : exComSeveritiesEnum; (*Severity of the error*)
		Code : UINT; (*Error code*)
	END_STRUCT;
END_TYPE
