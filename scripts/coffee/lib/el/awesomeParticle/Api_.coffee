module.exports = class Api_

	size: (x) ->

		@_params.size[0] = x

		@

	getSize: ->

		@_params.size[0]

	moveXTo: (x) ->

		@_params.pos[0] = x

		@

	moveX: (x) ->

		@_params.pos[0] += x

		@

	moveYTo: (y) ->

		@_params.pos[1] = y

		@

	moveY: (y) ->

		@_params.pos[1] += y

		@

	moveZTo: (z) ->

		@_params.pos[2] = z

		@

	moveZ: (z) ->

		@_params.pos[2] += z

		@

	getMovement: ->

		@_params.pos

		@

	moveTo: (x, y, z) ->

		@_params.pos[0] = x
		@_params.pos[1] = y
		@_params.pos[2] = z

		@

	move: (x, y, to) ->

		@_params.pos[0] += x
		@_params.pos[1] += y
		@_params.pos[2] += z

		@

	rotateZTo: (z) ->

		@_params.zRotation[0] = z

		@

	rotateZ: (z) ->

		@_params.zRotation[0] += z

		@

	getZRotation: ->

		@_params.zRotation[0]

	color: (r, g, b, a) ->

		@_params.color[0] = r
		@_params.color[1] = g
		@_params.color[2] = b
		@_params.color[3] = a

		@

	getColor: ->

		@_params.color