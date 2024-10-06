' ERROR mumners and messages

  Dim Shared ERR_TEXT$(520)

' Recoverable errors

Const ERR_SYNTAX = 2: ERR_TEXT$(ERR_SYNTAX) = "Syntax error" ' READ attempted to read a number but could not parse the next DATA item.
Const ERR_NO_GOSUB = 3: ERR_TEXT$(ERR_NO_GOSUB) = "RETURN without GOSUB"
Const ERR_OUT_OF_DATA = 4: ERR_TEXT$(ERR_OUT_OF_DATA) = "Out of DATA" ' The READ statement has read past the end of a DATA block. Use RESTORE to change the current data item if necessary.
Const ERR_ILL_FN_CALL = 5: ERR_TEXT$(ERR_ILL_FN_CALL) = "Illegal function call" 'A function was called with invalid parameters, in the wrong graphics mode or otherwise in an illegal fashion. Illegal Function gives some suggestions. "
Const ERR_OVERFLOW = 6: ERR_TEXT$(ERR_OVERFLOW) = "Overflow"
Const ERR_NO_MEMORY = 7: ERR_TEXT$(ERR_NO_MEMORY) = "Out of memory" ' Generic out of memory condition.
Const ERR_BAD_SUBSCRIPT = 9: ERR_TEXT$(ERR_BAD_SUBSCRIPT) = "Subscript out of range"
Const ERR_DUP_DEF = 10: ERR_TEXT$(ERR_DUP_DEF) = "Duplicate definition"
Const ERR_BAD_TYPE = 13: ERR_TEXT$(ERR_BAD_TYPE) = "Type mismatch." ' PRINT USING format string did not match the type of the supplied variables.
Const ERR_ILL_RESUME = 20: ERR_TEXT$(ERR_ILL_RESUME) = "RESUME without error"
Const ERR_FIELD_OFLO = 50: ERR_TEXT$(ERR_FIELD_OFLO) = "FIELD overflow"
Const ERR_INTERNAL = 51: ERR_TEXT$(ERR_INTERNAL) = "Internal error" '. Generic error
Const ERR_FNAME_OR_NUM = 52: ERR_TEXT$(ERR_FNAME_OR_NUM) = "Bad file name or number"
Const ERR_FILE_NOT_FOUND = 53: ERR_TEXT$(ERR_FILE_NOT_FOUND) = "File not found"
Const ERR_BAD_FILE_MODE = 54: ERR_TEXT$(ERR_BAD_FILE_MODE) = "Bad file mode"
Const ERR_FILE_IS_OPEN = 55: ERR_TEXT$(ERR_FILE_IS_OPEN) = "File already open"
Const ERR_BAD_REC_LEN = 59: ERR_TEXT$(ERR_BAD_REC_LEN) = "Bad record length:"
Const ERR_READ_AFTER_EOF = 62: ERR_TEXT$(ERR_READ_AFTER_EOF) = "Input past end of file"
Const ERR_BAD_REC_NUM = 63: ERR_TEXT$(ERR_BAD_REC_NUM) = "Bad record number"
Const ERR_BAD_FILE_NAME = 64: ERR_TEXT$(ERR_BAD_FILE_NAME) = "Bad file name"
Const ERR_DEV_UNAVAIL = 68: ERR_TEXT$(ERR_DEV_UNAVAIL) = "Device unavailable"
Const ERR_FORBIDDEN = 70: ERR_TEXT$(ERR_FORBIDDEN) = "Permission denied"
Const ERR_BAD_PATH = 75: ERR_TEXT$(ERR_BAD_PATH) = "Path/File access error"
Const ERR_PATH_NOT_FOUND = 76: ERR_TEXT$(ERR_PATH_NOT_FOUND) = "Path not found"
Const ERR_INV_HANDLE = 258: ERR_TEXT$(ERR_INV_HANDLE) = "Invalid handle"

'  Critical errors,
'  These errors can be triggered in QB64 but will not be caught by an ON ERROR handler.
'  They are always fatal, causing the program to exit.

Const ERR_DIV_ZERO = 11: ERR_TEXT$(ERR_DIV_ZERO) = "Division by zero"
Const ERR_NO_STACK = 256: ERR_TEXT$(ERR_NO_STACK) = "Out of stack space"
Const ERR_NO_MEM = 257: ERR_TEXT$(ERR_NO_MEM) = "Out of memory"
Const ERR_NO_DYN_LIB = 259: ERR_TEXT$(ERR_NO_DYN_LIB) = "Cannot find dynamic library file"
Const ERR_DYN_LBR_SUB = 260: ERR_TEXT$(ERR_DYN_LBR_SUB) = "Sub/Function does not exist in dynamic library"
Const ERR_STATIC_LBR_SUB = 261: ERR_TEXT$(ERR_STATIC_LBR_SUB) = "Sub/Function does not exist in static library|"
Const ERR_GL_OUT_OF_SCOPE = 270: ERR_TEXT$(ERR_GL_OUT_OF_SCOPE) = "_GL command called outside of SUB _GL's scope"
Const ERR_END_IN_GL_SUB = 271: ERR_TEXT$(ERR_END_IN_GL_SUB) = "END/SYSTEM called within SUB _GL's scope"
Const ERR_MEM_OUT_RANGE = 300: ERR_TEXT$(ERR_MEM_OUT_RANGE) = "Memory region out of range" '   Triggered by _MEM commands
Const ERR_INVALID_SIZE = 301: ERR_TEXT$(ERR_INVALID_SIZE) = "Invalid size"
Const ERR_MEM_SRC_BAD = 302: ERR_TEXT$(ERR_MEM_SRC_BAD) = "Source memory region out of range"
Const ERR_MEM_DEST_BAD = 303: ERR_TEXT$(ERR_MEM_DEST_BAD) = "Destination memory region out of range"
Const ERR_MEM_SRC_DES_BAD = 304: ERR_TEXT$(ERR_MEM_SRC_DES_BAD) = "Source and destination memory regions out of range"
Const ERR_MEM_SRC_GONE = 305: ERR_TEXT$(ERR_MEM_SRC_GONE) = "Source memory has been freed"
Const ERR_MEM_DEST_GONE = 306: ERR_TEXT$(ERR_MEM_DEST_GONE) = "Destination memory has been freed"
Const ERR_MEM_ALR_FREED = 307: ERR_TEXT$(ERR_MEM_ALR_FREED) = "Memory already freed"
Const ERR_MEM_FREED = 308: ERR_TEXT$(ERR_MEM_FREED) = "Memory has been freed"
Const ERR_MEM_NO_INIT = 309: ERR_TEXT$(ERR_MEM_NO_INIT) = "Memory not initialized"
Const ERR_MEM_SRC_NO_INIT = 310: ERR_TEXT$(ERR_MEM_SRC_NO_INIT) = "Source memory not initialized"
Const ERR_MEM_DEST_NO_INIT = 311: ERR_TEXT$(ERR_MEM_DEST_NO_INIT) = "Destination memory not initialized"
Const ERR_MEM_SD_NO_INIT = 312: ERR_TEXT$(ERR_MEM_SD_NO_INIT) = "Source and destination memory not initialized"
Const ERR_MEM_SD_FREED = 313: ERR_TEXT$(ERR_MEM_SD_FREED) = "Source and destination memory have been freed" '   Triggered by _MEM commands
Const ERR_MEM_ASRT_FAIL_1 = 314: ERR_TEXT$(ERR_MEM_ASRT_FAIL_1) = "_ASSERT failed" '  See _ASSERT
Const ERR_MEM_ASRT_FAIL_2 = 315: ERR_TEXT$(ERR_MEM_ASRT_FAIL_2) = "_ASSERT failed (check console for description)" '  See _ASSERT.
Const ERR_MEM_502 = 502: ERR_TEXT$(ERR_MEM_502) = "Out of memory error #502" '  Generic out of memory condition.
Const ERR_MEM_503 = 503: ERR_TEXT$(ERR_MEM_503) = "Out of memory error #503"
Const ERR_MEM_504 = 504: ERR_TEXT$(ERR_MEM_504) = "Out of memory error #504"
Const ERR_MEM_505 = 505: ERR_TEXT$(ERR_MEM_505) = "Out of memory error #505"
Const ERR_MEM_506 = 506: ERR_TEXT$(ERR_MEM_506) = "Out of memory error #506"
Const ERR_MEM_507 = 507: ERR_TEXT$(ERR_MEM_507) = "Out of memory error #507"
Const ERR_MEM_508 = 508: ERR_TEXT$(ERR_MEM_508) = "Out of memory error #508"
Const ERR_MEM_509 = 509: ERR_TEXT$(ERR_MEM_509) = "Out of memory error #509"
Const ERR_MEM_510 = 510: ERR_TEXT$(ERR_MEM_510) = "Out of memory error #510"
Const ERR_MEM_511 = 511: ERR_TEXT$(ERR_MEM_511) = "Out of memory error #511"
Const ERR_MEM_512 = 512: ERR_TEXT$(ERR_MEM_512) = "Out of memory error #512"
Const ERR_MEM_513 = 513: ERR_TEXT$(ERR_MEM_513) = "Out of memory error #513"
Const ERR_MEM_514 = 514: ERR_TEXT$(ERR_MEM_514) = "Out of memory error #514"
Const ERR_MEM_515 = 515: ERR_TEXT$(ERR_MEM_515) = "Out of memory error #515"
Const ERR_MEM_516 = 516: ERR_TEXT$(ERR_MEM_516) = "Out of memory error #516"
Const ERR_MEM_517 = 517: ERR_TEXT$(ERR_MEM_517) = "Out of memory error #517"
Const ERR_MEM_518 = 518: ERR_TEXT$(ERR_MEM_518) = "Out of memory error #518"

'   Legacy errors

'   These errors will never be generated by a genuine error condition, and can only be triggered by
'   explicit use of the ERROR command. They can all be caught by ON ERROR.

Const ERR_NO_FOR_STMT = 1: ERR_TEXT$(ERR_NO_FOR_STMT) = "NEXT without FOR"
Const ERR_NO_LABEL = 8: ERR_TEXT$(ERR_NO_LABEL) = "Label not defined"
Const ERR_NO_DIRECT = 12: ERR_TEXT$(ERR_NO_DIRECT) = "Illegal in direct mode"
Const ERR_STRING_SPACE = 14: ERR_TEXT$(ERR_STRING_SPACE) = "Out of string space"
Const ERR_STR_TOO_CMPLX = 16: ERR_TEXT$(ERR_STR_TOO_CMPLX) = "String formula too complex"
Const ERR_NO_CONTINUE = 17: ERR_TEXT$(ERR_NO_CONTINUE) = "Cannot continue"
Const ERR_UNDEF_FUNC = 18: ERR_TEXT$(ERR_UNDEF_FUNC) = "Function not defined"
Const ERR_NO_RESUME = 19: ERR_TEXT$(ERR_NO_RESUME) = "No RESUME"
Const ERR_DEV_TIMEOUT = 24: ERR_TEXT$(ERR_DEV_TIMEOUT) = "Device timeout"
Const ERR_DEV_FAULT = 25: ERR_TEXT$(ERR_DEV_FAULT) = "Device fault"
Const ERR_NO_NEXT_STMT = 26: ERR_TEXT$(ERR_NO_NEXT_STMT) = "FOR without NEXT"
Const ERR_NO_PAPER = 27: ERR_TEXT$(ERR_NO_PAPER) = "Out of paper"
Const ERR_NO_WEND = 29: ERR_TEXT$(ERR_NO_WEND) = "WHILE without WEND"
Const ERR_NO_WHILE = 30: ERR_TEXT$(ERR_NO_WHILE) = "WEND without WHILE"
Const ERR_DUP_LABEL = 33: ERR_TEXT$(ERR_DUP_LABEL) = "Duplicate label"
Const ERR_UNDEF_SUB = 35: ERR_TEXT$(ERR_UNDEF_SUB) = "Subprogram not defined"
Const ERR_ARG_MISMATCH = 37: ERR_TEXT$(ERR_ARG_MISMATCH) = "Argument-count mismatch"
Const ERR_UNDEF_ARRAY = 38: ERR_TEXT$(ERR_UNDEF_ARRAY) = "Array not defined"
Const ERR_VAR_REQUIRED = 40: ERR_TEXT$(ERR_VAR_REQUIRED) = "Variable required"
Const ERR_FIELD_ACTIVE = 56: ERR_TEXT$(ERR_FIELD_ACTIVE) = "FIELD statement active"
Const ERR_DEV_IO = 57: ERR_TEXT$(ERR_DEV_IO) = "Device I/O error"
Const ERR_FILE_EXISTS = 58: ERR_TEXT$(ERR_FILE_EXISTS) = "File already exists"
Const ERR_DISK_FULL = 61: ERR_TEXT$(ERR_DISK_FULL) = "Disk full"
Const ERR_TOO_MANY_FILES = 67: ERR_TEXT$(ERR_TOO_MANY_FILES) = "Too many files"
Const ERR_COMM_BUF_OVFLO = 69: ERR_TEXT$(ERR_COMM_BUF_OVFLO) = "Communication-buffer overflow"
Const ERR_DISK_NOT_READY = 71: ERR_TEXT$(ERR_DISK_NOT_READY) = "Disk not ready"
Const ERR_DISK_MEDIA = 72: ERR_TEXT$(ERR_DISK_MEDIA) = "Disk-media error"
Const ERR_FEAT_UNAVAIL = 73: ERR_TEXT$(ERR_FEAT_UNAVAIL) = "Feature unavailable"
Const ERR_REN_ACR_DISKS = 74: ERR_TEXT$(ERR_REN_ACR_DISKS) = "Rename across disks"

