ParticleElement = require './ParticleElement'
ParticlePainter = require './ParticlePainter'
_Pool = require '../_Pool'

module.exports = class ParticlePool extends _Pool

	self = @

	constructor: (scene, @count, @flags) ->

		super

		@_allElements = []

		@_remainingElements = []

		@_left = @count

		do @_prepare

	_prepare: ->

		@_painter = new ParticlePainter @_scene, @flags, @count

		@_paramHolders = @_painter.getParamHolders()

		for i in [0...@count]

			el = new ParticleElement @_scene, @, @_painter, @_paramHolders[i], @flags

			@_allElements.push el
			@_remainingElements.push el

		return

	take: (el) ->

		el._disable()

		@_remainingElements.push el

		@_left++

		@

	get: ->

		if @_left is 0

			throw Error "All elements in the pool are already in use"

		@_left--

		el = @_remainingElements.shift()

		el._enable()

		el

	replacePositionData: (newData) ->

		@_painter.replacePositionData newData

		@

	getBuffers: ->

		@_paramHolders.__buffers

	_redraw: ->

		@_painter.paint @_paramHolders, @count

		return