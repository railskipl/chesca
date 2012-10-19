$(document).ready(function(){
		
	// first example
	$("#navigation").treestructure({
		collapsed: true,
		unique: true,
		persist: "location"
	});

	
	// second example
	$("#browser").treestructure({
		animated:"normal",
		persist: "cookie"
	});

	$("#samplebutton").click(function(){
		var branches = $("<li><span class='folder'>New Sublist</span><ul>" + 
			"<li><span class='file'>Item1</span></li>" + 
			"<li><span class='file'>Item2</span></li></ul></li>").appendTo("#browser");
		$("#browser").treestructure({
			add: branches
		});
	});


	// third example
	$("#reds").treestructure({
		animated: "fast",
		collapsed: true,
		control: "#treecontrol"
	});


});