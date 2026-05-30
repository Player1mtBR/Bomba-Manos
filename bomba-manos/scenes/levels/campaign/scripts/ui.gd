extends Control

##ta implementado erradissimo mas ñ tem mais tempo
func _physics_process(delta: float) -> void: ##physics pq ja tem mt coisa na thread de process
	var scoreText = "P1\n\n("+str(GlobalScript.playerScores[1])+")\n\n---\n\nP2\n\n("+str(GlobalScript.playerScores[2])+")"
	$score.text = scoreText
	var manelScoreText = "M\nA\nN\nE\nL\n\n("+str(GlobalScript.playerScores[0])+")"
	$scoreManel.text = manelScoreText
	
	
	"""$score.text = "P1\n("+str(GlobalScript)")

---

P2

("0")"
"""
