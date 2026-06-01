extends Node2D

var generators := {}
var barriers := {}

func registerGenerator(generatorId, generatorNode):
	if not generators.has(generatorId):
		generators[generatorId] = []
	generators[generatorId].append(generatorNode)

func registerBarrier(generatorId, barrierNode):
	if not barriers.has(generatorId):
		barriers[generatorId] = []

	barriers[generatorId].append(barrierNode)
	
func checkGenerators(generatorId):
	if not generators.has(generatorId):
		return

	var pair = generators[generatorId]
	var disabledCount := 0

	for generator in pair:
		if generator.disabled:
			disabledCount += 1
	
	if disabledCount >= 2:
		for generator in pair:
			generator.destroy()
			
		destroyBarrier(generatorId)
			
func destroyBarrier(generatorId):
	if not barriers.has(generatorId):
		return

	for barrier in barriers[generatorId]:
		if is_instance_valid(barrier):
			barrier.destroy()
