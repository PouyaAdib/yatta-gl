_Program = require '../_Program'

vert = """
attribute vec3 vx;

uniform vec2 uDims;

void main(void) {
	gl_Position = vec4(vx, 1) * vec4(uDims, 1, 1);
}
"""

frag = """
precision mediump float;

void main() {
	gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}
"""

module.exports = class WhiteRectangleProgram extends _Program

	self = @

	# Here, programs aren't limited to webgl programs, and come
	# with predefined shapes and geometries, among other things.
	@_vertices: new Float32Array [
		-1, -1, 0,
		-1,  1, 0,
		 1, -1, 0,

		 1, -1, 0,
		-1,  1, 0,
		 1,  1, 0
	]

	constructor: ->

		super

		@_dims = new Float32Array 2

		@_transformation = null

		@_program = @_gila.makeProgram vert, frag, 'whiteRectangleProgram'

		@_program.activate()

		@_vxAttr = @_program.attr 'vx'

		@_vxAttr.enable()

		@_vxBuffer = @_gila.makeArrayBuffer()

		@_dimsUniform = @_program.uniform '2f', 'uDims'

	setDims: (x, y) ->

		@_dims[0] = x

		@_dims[1] = y

		@

	setTransformation: (t) ->

		@_transformation = t

		@

	_reset: ->

		@setDims 0, 0

		@setTransformation null

		return

	_activate: ->

		@_program.activate()

		return

	draw: ->

		do @_activate

		@_dimsUniform.set @_dims[0], @_dims[1]

		@_vxBuffer.data self._vertices

		@_vxAttr.readAsFloat 3, no, 0, 0

		@_gila.drawTriangles 0, 6

		do @_reset

		@