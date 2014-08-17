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
		row = $(this).closest("tr")
		row.insertBefore( row.prev() )

trashTableClick = (table) ->
	table.find(".backHead").find(".glyphicon-trash").click ->
		$(this).closest(".shapeTable").fadeOut("normal")

trashRowClick = (row) ->
	row.find(".glyphicon-trash").click ->
		$(this).closest(".taskProp").fadeOut("normal")

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

	$("input[type=checkbox]").click ->
		if $(this).is(":checked") 
			$(this).closest(".taskProp").css( "background-color", "orange" )
		else
			$(this).closest(".taskProp").css( "background-color", "white" )



	
