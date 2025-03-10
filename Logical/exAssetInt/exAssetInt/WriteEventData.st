// -------------------------------------------------------------------------------------------
// File version 1000
// -------------------------------------------------------------------------------------------
// Write event data
// -------------------------------------------------------------------------------------------
FUNCTION_BLOCK WriteEventData
	// -------------------------------------------------------------------------------------------
	// Reset everything when enable is false
	IF NOT Enable THEN
		Status := ERR_FUB_ENABLE_FALSE;
		State := 0;		
	END_IF
	
	CASE State OF
		// -------------------------------------------------------------------------------------------
		// Wait for enable
		0:
			IF EDGEPOS(Enable) THEN
				brsmemcpy(ADR(RecordDataIntern), RecordData, SIZEOF(RecordDataIntern));				
				
				// Reset function blocks
				FileOpen_0.enable := FALSE;
				FileOpen_0();
				FileCreate_0.enable := FALSE;
				FileCreate_0();
				FileWrite_0.enable := FALSE;
				FileWrite_0();
				FileClose_0.enable := FALSE;
				FileClose_0();

				// Generate file name
				RecordDataIntern.FileName := CORE_FOLDER_NAME;
				brsstrcat(ADR(RecordDataIntern.FileName), ADR('/event#'));
				brsitoa(RecordIndex, ADR(TmpStr1));
				brsstrcat(ADR(RecordDataIntern.FileName), ADR(TmpStr1));
				
				Status := ERR_FUB_BUSY;
				TmpStr1 := 'creating new event type > ';
				brsitoa(RecordDataIntern.EventType, ADR(TmpStr2));
				brsstrcat(ADR(TmpStr1), ADR(TmpStr2));
				CreateLoggerEntry(exASSETINT_LOG_INFO, ADR(TmpStr1), Logger);
				State := 1;
			END_IF

			// -------------------------------------------------------------------------------------------
			// Open file
		1:
			FileOpen_0.enable := TRUE;
			FileOpen_0.pDevice := ADR(Device);
			FileOpen_0.pFile := ADR(RecordDataIntern.FileName);
			FileOpen_0.mode := fiREAD_WRITE;
			FileOpen_0();
	
			// File opened successful
			IF FileOpen_0.status = ERR_OK THEN
				// Generate log entry
				TmpStr1 := 'open event file ok > ';
				brsstrcat(ADR(TmpStr1), ADR(RecordDataIntern.FileName));
				CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
				
				// Remember ident go to next step
				Ident := FileOpen_0.ident;
				State := 3;

				// Create event file when it does not exist
			ELSIF FileOpen_0.status = fiERR_FILE_NOT_FOUND  THEN
				State := 2;

				// Error
			ELSIF FileOpen_0.status <> ERR_FUB_BUSY THEN
				Status := FileOpen_0.status;
				State := 0;
			END_IF

			// -------------------------------------------------------------------------------------------
			// Create file
		2:
			FileCreate_0.enable := TRUE;
			FileCreate_0.pDevice := ADR(Device);
			FileCreate_0.pFile := ADR(RecordDataIntern.FileName);
			FileCreate_0();
	
			// File created successful
			IF FileCreate_0.status = ERR_OK THEN
				// Generate log entry
				TmpStr1 := 'create event file ok > ';
				brsstrcat(ADR(TmpStr1), ADR(RecordDataIntern.FileName));
				CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
				
				// Remember ident go to next step
				Ident := FileCreate_0.ident;
				State := 3;
				
				// Error
			ELSIF FileCreate_0.status <> ERR_FUB_BUSY THEN
				Status := FileCreate_0.status;
				State := 0;
			END_IF
		
			// -------------------------------------------------------------------------------------------
			// Write data
		3:
			// Add file name to record
			RecordDataIntern.CRC := CalcCrc(ADR(RecordDataIntern), SIZEOF(RecordDataIntern));	
			
			FileWrite_0.enable := TRUE;
			FileWrite_0.ident := Ident;
			FileWrite_0.pSrc := ADR(RecordDataIntern);
			FileWrite_0.len := SIZEOF(RecordDataIntern);
			FileWrite_0();
	
			// File created successful
			IF FileWrite_0.status = ERR_OK THEN
				// Generate log entry
				TmpStr1 := 'write event file ok > ';
				brsstrcat(ADR(TmpStr1), ADR(RecordDataIntern.FileName));
				CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
				
				// Go to next step
				State := 4;
				
				// Error
			ELSIF FileWrite_0.status <> ERR_FUB_BUSY THEN
				Status := FileWrite_0.status;
				State := 0;
			END_IF

			// -------------------------------------------------------------------------------------------
			// Close file
		4:
			FileClose_0.enable := TRUE;
			FileClose_0.ident := Ident;
			FileClose_0();
	
			// File created successful
			IF FileClose_0.status = ERR_OK THEN
				// Generate log entry
				TmpStr1 := 'close event file ok > ';
				brsstrcat(ADR(TmpStr1), ADR(RecordDataIntern.FileName));
				CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
				
				// Finish up
				brsmemcpy(RecordData, ADR(RecordDataIntern), SIZEOF(RecordDataIntern));				
				Status := ERR_OK;
				State := 0;
				
				// Error
			ELSIF FileClose_0.status <> ERR_FUB_BUSY THEN
				Status := FileClose_0.status;
				State := 0;
			END_IF
	END_CASE;

END_FUNCTION_BLOCK

