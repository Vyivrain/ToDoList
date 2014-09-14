# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

showPencil = (el) ->
	el.find(".glyphicon-pencil").fadeIn("normal")
hidePencil = (el) ->
	el.find(".glyphicon-pencil").fadeOut("normal")
showTrash = (el) ->
	el.find(".glyphicon-trash").fadeIn("normal")
hideTrash = (el) ->
	el.find(".glyphicon-trash").fadeOut("normal")
showArrow = (el) ->
	el.find(".glyphicon-sort").fadeIn("normal")
hideArrow = (el) ->
	el.find(".glyphicon-sort").fadeOut("normal")

showHeader = (table) ->
	table.mouseenter ->
		showPencil($(this).find(".backHead"))
		showTrash($(this).find(".backHead"))

hideHeader = (table) ->
	table.mouseleave ->
		hidePencil($(this).find(".backHead"))
		hideTrash($(this).find(".backHead"))

showRow = (row) ->
	row.mouseenter ->
		showPencil($(this))
		showTrash($(this))
		showArrow($(this))

hideRow = (row) ->
	row.mouseleave ->
		hidePencil($(this))
		hideTrash($(this))
		hideArrow($(this))

swapRows = (rowTable) ->
	rowTable.find(".glyphicon-sort").click ->
		$.cookie("swap", "")
		row = $(this).closest("tr")
		row_id = row.find(".check").attr("id")
		prev_row_id = row.prev().find(".check").attr("id")
		$.cookie( "swap", $.cookie("swap") + row_id + "&" + prev_row_id, { path: '/' } )
		row.insertBefore( row.prev() )

		$.ajax({
				url: 'tasks/update_data'
				type: 'POST'
				data: { swap: $.cookie("swap") }
			})

		$.cookie( "swap", "", { path: '/' } )
		

trashTableClick = (table) ->
	table.find(".backHead").find(".glyphicon-trash").click ->
		$(this).closest(".shapeTable").fadeOut("normal")

trashRowClick = (row) ->
	row.find(".glyphicon-trash").click ->
		$(this).closest(".taskProp").fadeOut("normal")

checkClick = (checkbox) ->
	checkbox.click ->
		value = $(this).attr("id")
		if $(this).prop("checked") 
			$(this).closest(".taskProp").css( "background-color", "orange" )
			$.cookie( value , "show", { path: '/' } )
		else
			$(this).closest(".taskProp").css( "background-color", "white" )
			$.cookie( value , "hide", { path: '/' } )

saveCheck = (checkbox) ->
	checkbox.each ->
		value = $(this).attr("id")
		if $.cookie(value) == "show"
			$(this).prop('checked', true )
			$(this).closest(".taskProp").css( "background-color", "orange" )

checkInput = (input) ->
	input.click ->
		el = $(this).siblings(".textField")
		el.effect("highlight", {color:"#FF7575"}, 1000) if el.val() == ""

$(document).ready ->
	table = $(".shapeTable")
	rowTable = $(".taskProp")
	checkbox = $("input[type=checkbox]")

	showHeader(table)
	hideHeader(table)
	showRow(rowTable)
	hideRow(rowTable)

	swapRows(rowTable)
	trashTableClick(table)
	trashRowClick(rowTable)
	checkClick(checkbox)
	
	saveCheck(checkbox)
	
	checkInput( $(".buttonTask") )
			
					  
	

