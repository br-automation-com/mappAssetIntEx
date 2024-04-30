//// -------------------------------------------------------------------------------------------
//// Read event data
//// -------------------------------------------------------------------------------------------
//FUNCTION_BLOCK ExportEventData
//	// -------------------------------------------------------------------------------------------
//	// Reset everything when enable is false
//	IF NOT Enable THEN
//		Status := ERR_FUB_ENABLE_FALSE;
//		State := 0;		
//	END_IF
//	
//	CASE State OF
//		// -------------------------------------------------------------------------------------------
//		// Wait for enable
//		0:
//			IF EDGEPOS(Enable) THEN
//				// Reset function blocks
//				DirOpen_0.enable := FALSE;
//				DirOpen_0();
//				DirReadEx_0.enable := FALSE;
//				DirReadEx_0();
//				DirClose_0.enable := FALSE;
//				DirClose_0();
//				FileOpen_0.enable := FALSE;
//				FileOpen_0();
//				FileRead_0.enable := FALSE;
//				FileRead_0();
//				FileClose_0.enable := FALSE;
//				FileClose_0();
//
//				// Generate folder name
//				DirCount := 0;
//				TimeFirst := 0;
//				DirName := 'events0';
//				
//				Status := ERR_FUB_BUSY;
//				CreateLoggerEntry(exASSETINT_LOG_INFO, ADR('raeding all events'), Logger);
//				State := 1;
//			END_IF
//
//		// -------------------------------------------------------------------------------------------
//		// Start reading folder
//		1:
//			DirOpen_0.enable := TRUE;
//			DirOpen_0.pDevice := ADR(Device);
//			DirOpen_0.pName := ADR(DirName);
//			DirOpen_0();
//	
//			// File created successful
//			IF DirOpen_0.status = ERR_OK THEN
//				// Generate log entry
//				TmpStr1 := 'open dir -> ';
//				brsstrcat(ADR(TmpStr1), ADR(DirName));
//				CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
//				
//				// Go to next step
//				State := 2;
//				
//			// Error
//			ELSIF DirOpen_0.status <> ERR_FUB_BUSY THEN
//				Status := DirOpen_0.status;
//				State := 0;
//			END_IF
//			
//		// -------------------------------------------------------------------------------------------
//		// Read next file name
//		2:
//			DirReadEx_0.enable := TRUE;
//			DirReadEx_0.ident := DirOpen_0.ident;
//			DirReadEx_0.pData := ADR(FileInfo_0);
//			DirReadEx_0.data_len := SIZEOF(FileInfo_0);
//			DirReadEx_0();
//	
//			// New file found
//			IF DirReadEx_0.status = ERR_OK THEN
//				IF brsstrcmp(ADR(FileInfo_0.Filename), ADR('.')) <> 0 AND brsstrcmp(ADR(FileInfo_0.Filename), ADR('..')) <> 0 THEN			
//					// Generate log entry
//					TmpStr1 := 'found file -> ';
//					brsstrcat(ADR(TmpStr1), ADR(FileInfo_0.Filename));
//					CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
//	
//					State := 4;
//				END_IF
//
//			// No more entries
//			ELSIF DirReadEx_0.status = fiERR_NO_MORE_ENTRIES THEN
//				// Generate log entry
//				TmpStr1 := 'read all events ok ';
//				brsstrcat(ADR(TmpStr1), ADR(DirName));
//				CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
//
//				State := 3;
//				
//			// Error
//			ELSIF DirReadEx_0.status <> ERR_FUB_BUSY THEN
//				Status := DirReadEx_0.status;
//				State := 0;
//			END_IF
//			
//		// -------------------------------------------------------------------------------------------
//		// Finish reading folder
//		3:
//			DirClose_0.enable := TRUE;
//			DirClose_0.ident := DirOpen_0.ident;
//			DirClose_0();
//	
//			// Directory closed successful
//			IF DirClose_0.status = ERR_OK THEN
//				// Generate log entry
//				TmpStr1 := 'close dir ok -> ';
//				brsstrcat(ADR(TmpStr1), ADR(DirName));
//				CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
//				
//				// Open next directory, finish when all folders are created
//				DirCount := DirCount + 1;
//				IF DirCount >= CORE_EVENT_NUM_MAX / CORE_EVENT_DIR_MAX THEN
//					Status := ERR_OK;
//					State := 0;
//					
//				// Generate next folder name
//				ELSE
//					DirName := 'events';
//					brsitoa(DirCount, ADR(TmpStr2));
//					brsstrcat(ADR(DirName), ADR(TmpStr2));
//					State := 1;
//				END_IF
//				
//			// Error
//			ELSIF DirClose_0.status <> ERR_FUB_BUSY THEN
//				Status := DirClose_0.status;
//				State := 0;
//			END_IF
//			
//		// -------------------------------------------------------------------------------------------
//		// Open event file
//		4:
//			// Generate file name
//			FileName := DirName;
//			brsstrcat(ADR(FileName), ADR('/'));
//			brsstrcat(ADR(FileName), ADR(FileInfo_0.Filename));
//			
//			// Open file
//			FileOpen_0.enable := TRUE;
//			FileOpen_0.pDevice := ADR(Device);
//			FileOpen_0.pFile := ADR(FileName);
//			FileOpen_0.mode := fiREAD_ONLY;
//			FileOpen_0();
//	
//			// File opened successful
//			IF FileOpen_0.status = ERR_OK THEN
//				// Generate log entry
//				TmpStr1 := 'open event file ok -> ';
//				brsstrcat(ADR(TmpStr1), ADR(FileName));
//				CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
//				
//				// Make sure data has correct size
//				IF FileOpen_0.filelen <> SIZEOF(RecordData) THEN
//					TmpStr1 := 'data in event file has wrong size -> ';
//					brsstrcat(ADR(TmpStr1), ADR(FileName));
//					CreateLoggerEntry(exASSETINT_LOG_ERROR, ADR(TmpStr1), Logger);
//					Status := ERR_ASSET_READ_RECORD_SIZE;
//					
//					State := 6;
//				ELSE
//					State := 5;
//				END_IF
//				
//				// Error
//			ELSIF FileOpen_0.status <> ERR_FUB_BUSY THEN
//				Status := FileOpen_0.status;
//				State := 0;
//			END_IF	
//		
//		// -------------------------------------------------------------------------------------------
//		// Read event data
//		5:
//			FileRead_0.enable := TRUE;
//			FileRead_0.ident := FileOpen_0.ident;
//			FileRead_0.pDest := ADR(RecordData);
//			FileRead_0.len := FileOpen_0.filelen;
//			FileRead_0();
//	
//			// File read successful
//			IF FileRead_0.status = ERR_OK THEN
//				// Generate log entry
//				TmpStr1 := 'read event file ok -> ';
//				brsstrcat(ADR(TmpStr1), ADR(FileName));
//				CreateLoggerEntry(exASSETINT_LOG_INFO, ADR(TmpStr1), Logger);
//				
//				// Check if record is newest
//				InsertEventData(Memory, RecordCount, RecordData);
//				
//				// Increase record count, go to next step
//				RecordCount := RecordCount + 1;
//				State := 6;
//				
//			// Error
//			ELSIF FileRead_0.status <> ERR_FUB_BUSY THEN
//				Status := FileRead_0.status;
//				State := 6;
//			END_IF
//
//		// -------------------------------------------------------------------------------------------
//		// Close file
//		6:
//			FileClose_0.enable := TRUE;
//			FileClose_0.ident := FileOpen_0.ident;
//			FileClose_0();
//	
//			// File closed successful
//			IF FileClose_0.status = ERR_OK THEN
//				// Generate log entry
//				TmpStr1 := 'close event file ok -> ';
//				brsstrcat(ADR(TmpStr1), ADR(FileName));
//				CreateLoggerEntry(exASSETINT_LOG_ALL, ADR(TmpStr1), Logger);
//				
//				// Abort if there was a previous error, else proceed with next file
//				IF Status <> ERR_FUB_BUSY THEN
//					State := 0;
//				ELSE
//					State := 2;
//				END_IF
//				
//			// Error
//			ELSIF FileClose_0.status <> ERR_FUB_BUSY THEN
//				Status := FileClose_0.status;
//				State := 0;
//			END_IF
//		
//	END_CASE;
//
//END_FUNCTION_BLOCK
//
//FUNCTION InsertEventData
//	x := 0;
//	y := 0;
//	sort := 0;
//
//	// Set up start values for iteration
//	IF RecordCount <> 0 THEN
//		y := RecordCount - 1;
//	END_IF
//	x := y;
//
//	// Start itteration	search
//	WHILE y > 1 DO
//		// Check current entry
//		RecordMemory ACCESS Memory + x*SIZEOF(RecordData);
//		sort := DiffDT(RecordData.TimeEnd, RecordMemory.TimeEnd);
//
//		// Solve new search range
//		IF y MOD 2 = 0 THEN
//			y := y / 2;
//		ELSE
//			y := y / 2 + 1;
//		END_IF
//
//		// New range is lower or higher than current
//		IF sort <> 16#FFFFFFFF THEN
//			x := x + y;
//			IF x > UINT_TO_INT(RecordCount) THEN
//				x := UINT_TO_INT(RecordCount);
//			END_IF
//		ELSE
//			x := x - y;
//			IF x < 1 THEN
//				x := 1;
//			END_IF
//		END_IF
//	END_WHILE;	
//
//	// New entry is this, next or previous
//	RecordMemory ACCESS Memory + x*SIZEOF(RecordData);
//	sort := DiffDT(RecordData.TimeEnd, RecordMemory.TimeEnd);
//
//	IF sort > 0 AND x <> UINT_TO_INT(RecordCount) THEN
//		x := x + 1;
//	ELSIF x > 0 THEN
//		RecordMemory ACCESS Memory + (x - 1)*SIZEOF(RecordData);
//		sort := DiffDT(RecordData.TimeEnd, RecordMemory.TimeEnd);
//		IF sort = 16#FFFFFFFF THEN
//			x := x - 1;
//		END_IF
//	END_IF
//	
//	// Move all entrys backwards and fill in new entry
//	brsmemmove(Memory + (x + 1)*SIZEOF(RecordData), Memory + x*SIZEOF(RecordData), (RecordCount - x)*SIZEOF(RecordData));
//	brsmemcpy(Memory + x*SIZEOF(RecordData), ADR(RecordData), SIZEOF(RecordData));
//
//	InsertEventData := TRUE;
//END_FUNCTION
