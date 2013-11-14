Timing = require 'raf-timing'
Gila = require '_gila'

module.exports = class Scene

	constructor: (idOrCanvas, debug = no) ->

		@_dims =

			# Actual width and height of the canvas
			width: 0
			height: 0

			# If we resize the canvas, and scale it up (to get lower resolution),
			# then we wouldn't want the size of our elements which are set
			# according to our resolution to change.
			perceivedWidth: 0
			parceivedHeight: 0

		@debug = Boolean debug

		@_setCanvas idOrCanvas

		@_children = []

		do @_initTiming

	_initTiming: ->

		@_shouldRedraw = no

		@timing = new Timing

		@_rafId = 0

		@_boundTick = (t) =>

			@_tick t

			return

		do @_scheduleRedraw

		return

	_tick: (t) ->

		@_shouldRedraw = no

		@_gila.clear()

		child.redraw() for child in @_children

		return

	_setCanvas: (idOrCanvas) ->

		if typeof idOrCanvas is 'string'

			canvas = document.getElementById idOrCanvas

			unless canvas?

				throw Error "Cannot find canvas with id '#{idOrCanvas}'"

		else

			canvas = idOrCanvas

		unless canvas instanceof HTMLCanvasElement

			throw Error "canvas must be a canvas element"

		@canvas = canvas


		@_dims.width = canvas.width
		@_dims.height = canvas.height

		@_dims.perceivedWidth = canvas.width
		@_dims.parceivedHeight = canvas.height

		do @_prepareGila

		return

	_prepareGila: ->

		@_gila = new Gila @canvas, @debug

		@_gila.setViewportDims 0, 0, @_dims.width, @_dims.height

		@_gila.clearColor 0, 0, 0, 0

		return

	_scheduleRedraw: ->

		return if @_shouldRedraw

		@_shouldRedraw = yes

		@_rafId = Timing.requestAnimationFrame @_boundTick

		return

	_adopt: (el) ->

		do @_scheduleRedraw

		@_children.push el

		return