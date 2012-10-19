$(document).ready(function(){
		
	// first example
	$("#navigation").treestructure1({
		collapsed: true,
		unique: true,
		persist: "location"
	});

	
	// second example
	$("#browser").treestructure1({
		animated:"normal",
		persist: "cookie"
	});

	$("#samplebutton").click(function(){
		var branches = $("<li><span class='folder'>New Sublist</span><ul>" + 
			"<li><span class='file'>Item1</span></li>" + 
			"<li><span class='file'>Item2</span></li></ul></li>").appendTo("#browser");
		$("#browser").treestructure1({
			add: branches
		});
	});


	// third example
	$("#redss").treestructure1({
		animated: "fast",
		collapsed: true,
		control: "#treecontrol"
	});


});