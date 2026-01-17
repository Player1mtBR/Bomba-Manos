import pygame

pygame.init()

#screen
currentScreen = pygame.display.set_mode((1280, 720))
isGameRunning = True

#gameClock
gameClock = pygame.time.Clock()
deltaTime = 0.1

#font 2 render text
font01 = pygame.font.Font(None, size=50)

#img coordinates
playerX = 100
playerY = 100

playerMoveSpeed = 100

#junk
"""isPlayerFacingUp = False
isPlayerFacingDown = True
isPlayerFacingLeft = False
isPlayerFacingRight = False
"""


#move player
isPlayerMoving = False

#load img
whiteBox_IMG = pygame.image.load("Bomba-Manos/assets/imgs/whiteBox.png").convert_alpha() #convert makes for faster rendering and convert_alpha is to tell pygame to use alpha channel
#scaleImg --> transform using scale
whiteBox_IMG = pygame.transform.scale(whiteBox_IMG, (whiteBox_IMG.get_width() * 3, whiteBox_IMG.get_height() * 3))

#main loop
while isGameRunning:
    currentScreen.fill((50, 50, 50))

    #img on screen
    currentScreen.blit(whiteBox_IMG, (playerX, playerY))

    #if input -> move up - down -left - right
    if isPlayerMoving:

        """if isPlayerFacingUp:
            playerY -= playerMoveSpeed * deltaTime

        if isPlayerFacingDown:
            playerY += playerMoveSpeed * deltaTime

        if isPlayerFacingLeft:
            playerX -= playerMoveSpeed * deltaTime

        if isPlayerFacingRight:
            playerX += playerMoveSpeed * deltaTime"""
        pass
        

    #text on screen
    text01 = font01.render("Anybody can find love (Except you).", True, (255, 255, 255))
    #render text
    currentScreen.blit(text01, (200, 200))

    #create hitbox
    hitbox01 = pygame.Rect(playerX, playerY, whiteBox_IMG.get_width(), whiteBox_IMG.get_height())

    hitboxTarget = pygame.Rect(900, 0, 100, 500)

    collisionDetector = hitbox01.colliderect(hitboxTarget) #detect hitbox01 collision relative to hitboxTarget (bool)

    #render rect using draw
    pygame.draw.rect(currentScreen, (111, 111 * collisionDetector, 111), hitboxTarget) #change color when colliding


    
    for event in pygame.event.get():

        #close game
        if event.type == pygame.QUIT:
            isGameRunning = False

        #key press
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_SPACE:
                #isPlayerMoving = True
                pass

            if (event.key == pygame.K_w):
                #isPlayerMoving = True
                #isPlayerFacingUp = True
                playerY -= playerMoveSpeed * deltaTime
                
            if (event.key == pygame.K_s):
                #isPlayerMoving = True
                #isPlayerFacingDown = True
                playerY += playerMoveSpeed * deltaTime

            if (event.key == pygame.K_a):
                #isPlayerMoving = True
                #isPlayerFacingLeft = True
                playerX -= playerMoveSpeed * deltaTime
                
            if (event.key == pygame.K_d):
                #isPlayerMoving = True
                #isPlayerFacingRight = True
                playerX += playerMoveSpeed * deltaTime



        """if (event.type == pygame.KEYUP) and (not event.type == pygame.KEYDOWN):
            if event.key == pygame.K_SPACE:
                #isPlayerMoving = False
                pass

            if (event.key == pygame.K_w):
                isPlayerMoving = False
                isPlayerFacingUp = False
                
            if (event.key == pygame.K_s):
                isPlayerMoving = False
                isPlayerFacingDown = False

            if (event.key == pygame.K_a):
                isPlayerMoving = False
                isPlayerFacingLeft = False
                
            if (event.key == pygame.K_d):
                isPlayerMoving = False
                isPlayerFacingRight = False"""


    #make stuff appear on window
    pygame.display.flip()

    deltaTime = gameClock.tick(60) / 1000 #miliseconds
    deltaTime = max(0.001, min(0.1, deltaTime))

#close pygame?
pygame.quit()