
TYPE
    MpDataErrorEnum : 
        ( (* Error numbers of library MpData *)
        mpDATA_NO_ERROR := 0, (* No error *)
        mpDATA_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
        mpDATA_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
        mpDATA_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
        mpDATA_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
        mpDATA_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
        mpDATA_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
        mpDATA_ERR_CONFIG_NULL := -1064239096, (* Configuration structure is null pointer [Error: 8, 0xc0910008] *)
        mpDATA_ERR_CONFIG_NO_PV := -1064239095, (* Configuration pointer not PV [Error: 9, 0xc0910009] *)
        mpDATA_ERR_CONFIG_LOAD := -1064239094, (* Error loading configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 10, 0xc091000a] *)
        mpDATA_WRN_CONFIG_LOAD := -2137980917, (* Warning loading configuration [Warning: 11, 0x8091000b] *)
        mpDATA_ERR_CONFIG_SAVE := -1064239092, (* Error saving configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 12, 0xc091000c] *)
        mpDATA_ERR_CONFIG_INVALID := -1064239091, (* Invalid Configuration [Error: 13, 0xc091000d] *)
        mpDATA_ERR_REGISTERING_PV := -1064124416, (* Could not registered PV {2:PVName} [Error: 49152, 0xc092c000] *)
        mpDATA_ERR_NO_PV_REGISTERED := -1064124415, (* No PV registered [Error: 49153, 0xc092c001] *)
        mpDATA_ERR_INVALID_PV_NAME := -1064124414, (* Invalid PV name [Error: 49154, 0xc092c002] *)
        mpDATA_ERR_PV_NAME_NULL := -1064124413, (* PV name null [Error: 49155, 0xc092c003] *)
        mpDATA_ERR_PV_REGISTERED := -1064124412, (* PV already registered [Error: 49156, 0xc092c004] *)
        mpDATA_ERR_FILE_SYSTEM := -1064124411, (* Save failure (ErrorCause: {1:ErrorNumber}) [Error: 49157, 0xc092c005] *)
        mpDATA_WRN_SAMPLING_TIME := -2137866234, (* Sampling time set as cycle time {2:SamplingTime} [Warning: 49158, 0x8092c006] *)
        mpDATA_ERR_INVALID_FILE_DEV := -1064124409, (* Invalid file device (data storage medium) [Error: 49159, 0xc092c007] *)
        mpDATA_ERR_DATAREC_NOT_FOUND := -1064124408, (* MpDataRecorder not found [Error: 49160, 0xc092c008] *)
        mpDATA_WRN_SAVE_INTERVAL := -2137866231, (* Invalid save interval. Save interval set to {2:SaveInterval} seconds [Warning: 49161, 0x8092c009] *)
        mpDATA_ERR_RECORD_FAILURE := -1064124406, (* Recording error (ErrorCause: {1:ErrorNumber}) [Error: 49162, 0xc092c00a] *)
        mpDATA_WRN_SAMPLING_TIME_MULTIP := -2137866229, (* Sampling time is not a multiple of task cycle time [Warning: 49163, 0x8092c00b] *)
        mpDATA_INF_WAIT_RECORDER_FB := 1083359244, (* Waiting for parent component [Informational: 49164, 0x4092c00c] *)
        mpDATA_ERR_MISSING_UICONNECT := -1064124403, (* Missing value on UIConnect [Error: 49165, 0xc092c00d] *)
        mpDATA_WRN_TOO_MANY_FILENAMES := -2137866226, (* Too many file names in a file ring buffer. Only last {2:NumberOfFiles} will be remembered after PLC restart [Warning: 49166, 0x8092c00e] *)
        mpDATA_ERR_INVALID_LIMITS := -1064124399 (* Limits were not specified correctly [Error: 49169, 0xc092c011] *)
        );
END_TYPE
