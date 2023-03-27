# Documentation for helpers

## editUserInfoForm

A widget that renders a form for the user to edit their basic user info, name, password, etc.

Usage:

```lua
local editUserInfoFormWidget = require("widgets.editUserInfoForm");
widget(editUserInfoFormWidget({
	makeFull = true, --Do we make this as an entire page or just as the form COMPONENTS i.e NO surrounding form tag
	editPassword = true
}));
```

