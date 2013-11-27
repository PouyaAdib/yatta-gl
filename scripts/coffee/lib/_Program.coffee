module.exports = class _Program

	constructor: (el) ->

		self = @constructor

		# make sure we use only one instance of every program
		sceneId = el._scene.id

		if self._instances?

			if self._instances[sceneId]?

				return self._instances[sceneId]

		else

			self._instances = {}

		self._instances[sceneId] = @

		@_scene = el._scene

		@_gila = el._scene._gila