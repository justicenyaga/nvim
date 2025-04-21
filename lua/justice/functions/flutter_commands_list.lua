local flutter_commands = {
	{
		text = "Run",
		label = "Run: Start a flutter project",
		execute = function()
			vim.cmd("FlutterRun")
		end,
	},
	{
		text = "List Devices",
		label = "List Devices: Show available physical devices",
		execute = function()
			vim.cmd("FlutterDevices")
		end,
	},
	{
		text = "List Emulators",
		label = "List Emulators: Show available emulator devices",
		execute = function()
			vim.cmd("FlutterEmulators")
		end,
	},
	{
		text = "Debug",
		label = "Debug: Force current project in debug mode",
		execute = function()
			vim.cmd("FlutterDebug")
		end,
	},
	{
		text = "Hot Reload",
		label = "Hot Reload: Reload a running project",
		execute = function()
			vim.cmd("FlutterReload")
		end,
	},
	{
		text = "Hot Restart",
		label = "Hot Restart: Restart a running project",
		execute = function()
			vim.cmd("FlutterRestart")
		end,
	},
	{
		text = "Quit",
		label = "Quit: Ends a running session",
		execute = function()
			vim.cmd("FlutterQuit")
		end,
	},
	{
		text = "Attach",
		label = "Attach: Attach to a running app",
		execute = function()
			vim.cmd("FlutterAttach")
		end,
	},
	{
		text = "Detach",
		label = "Detach: Ends a running session but keeps process running on device",
		execute = function()
			vim.cmd("FlutterDetach")
		end,
	},
	{
		text = "Toggle Outline",
		label = "Toggle Outline: Toggle current file widget tree",
		execute = function()
			vim.cmd("FlutterOutlineToggle")
		end,
	},
	{
		text = "Start Dev Tools",
		label = "Start Dev Tools: Starts a Dart Dev Tools Server",
		execute = function()
			vim.cmd("FlutterDevTools")
		end,
	},
	{
		text = "Active Dev Tools",
		label = "Active Dev Tools: Activates a Dart Dev Tools Server",
		execute = function()
			vim.cmd("FlutterDevToolsActivate")
		end,
	},
	{
		text = "Copy Profiler Url",
		label = "Copy Profiler Url: Copy the profiler url to the clipboard",
		execute = function()
			vim.cmd("FlutterCopyProfilerUrl")
		end,
	},
	{
		text = "Restart LSP",
		label = "Restart LSP: Restarts the dart language server",
		execute = function()
			vim.cmd("FlutterLspRestart")
		end,
	},
	{
		text = "Super",
		label = "Super: Go to super class, method",
		execute = function()
			vim.cmd("FlutterSuper")
		end,
	},
	{
		text = "Reanalyze",
		label = "Reanalyze: Force LSP server reanalyze using custom LSP method",
		execute = function()
			vim.cmd("FlutterReanalyze")
		end,
	},
	{
		text = "Rename",
		label = "Rename: Renames and updates imports",
		execute = function()
			vim.cmd("FlutterRename")
		end,
	},
	{
		text = "Clear Dev Log",
		label = "Clear Dev Log: Clear logs in the output buffer",
		execute = function()
			vim.cmd("FlutterLogClear")
		end,
	},
	{
		text = "Toggle Dev Log",
		label = "Toggle Dev Log: Toggles the log buffer",
		execute = function()
			vim.cmd("FlutterLogToggle")
		end,
	},
}

local pubspec_commands = {
	{
		text = "Add Dependency",
		label = "Add Dependency: Install a dependency",
		content = "Some description",
		data = "some data",
		execute = function()
			vim.cmd("PubspecAssistAddPackage")
		end,
	},
	{
		text = "Add Dev Dependency",
		label = "Add Dev Dependency: Install a dev dependency",
		content = "Some description",
		data = "some data",
		execute = function()
			vim.cmd("PubspecAssistAddDevPackage")
		end,
	},
	{
		text = "Select Dependency Version",
		label = "Select Dependency Version: List available dependency versions",
		content = "Some description",
		data = "some data",
		execute = function()
			vim.cmd("PubspecAssistPickVersion")
		end,
	},
}

return {
	flutter_commands = flutter_commands,
	pubspec_commands = pubspec_commands,
}
