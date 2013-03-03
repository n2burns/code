CmdUtils.CreateCommand({ 
	names: ["url"],
	arguments: [{role: "object", nountype: noun_arb_text, label: "url"}],
	execute: function (arguments) {
		Utils.openUrlInBrowser(arguments.object.html);
	}
});