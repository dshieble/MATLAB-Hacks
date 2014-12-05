%Press Run 



function stickFigure
    %misc important variables
    headDotStartX = 50;
    headDotStartY = 60;
    screenWidth = 300;
    screenHeight = 300;
    missleRadius = 4;
    %HP positions for player 1 (right)
    heartYPosition = screenHeight-20;
    heartXPosition = 20;
    heartRadius = 5;
    walkSpeed = 6;
    jumpMaxSpeed = 50;
    headRadius = 5;
    
    %body part starting coordinates
    headDot = [headDotStartX, headDotStartY];
    topBodyDot = [headDot(1), headDot(2)-headRadius];
    bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
    %right elbow
    elbowDotOne = [topBodyDot(1)+3,topBodyDot(2)-10];
    %left elbow
    elbowDotTwo = [topBodyDot(1)-3,topBodyDot(2)-10];
    %right hand
    handDotOne = [topBodyDot(1)+6,bottomBodyDot(2)];
    %left hand
    handDotTwo = [topBodyDot(1)-6,bottomBodyDot(2)];
    %right knee
    kneeDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-10];
    %left hand
    kneeDotTwo = [topBodyDot(1)-3,bottomBodyDot(2)-10];
    %right foot
    footDotOne = [bottomBodyDot(1)+6,bottomBodyDot(2)-20];
    %left foot
    footDotTwo = [bottomBodyDot(1)-6,bottomBodyDot(2)-20];
 


    %the following 2 parameters (esp the second two) denote the game difficulty
    missleSpeed = 4;
    missleBreakMax = 40;

    walkSpeedR = walkSpeed;
    walkSpeedL = walkSpeed*-1;
    jumpSpeed = 0;
    %1 is up, -1 is down
    pauseTime = 0.05;
    bodyPositionCounter = 0;
    %bodyPositionCounter -3 -> 0 -> walkLeft
    %bodyPositionCounter 0 -> 3 -> walkRight
    %bodyPositionCounter 4 -> 7 -> jump
    walkLeftGo = -1;
    walkRightGo = -1;
    jumpGo = -1;
    missleGo = -1;
    %missleCellCounter will contain within it the counter of which missle
    %we are on. When the counter reaches the length of missleCellArray, the
    %array is cleared and the counter is reset to 0
    missleCellCounter = 1;
    %keeps track of total number of missles fired
    totalMissleCounter = 1;
    %missleCellArray contains a cell index that correspondes to the missle,
    %and contains within each cell the coordinates of the missle, which is
    %changed via a particular function
    missleCellArray = cell(1,50);
    missleBreakCounter = 0;
    HP = 6;
    %flash variables
    flashCounter = 10;
    flash = 0;
    
    %fight game variables
    fightGo = -1;
    fightWalkCounter = 0;
    fightWalkRightGo = -1;
    fightWalkLeftGo = -1;
    guardOn = -1;
    punchCounter = 0;
    throwCounter = 0;
    %playerTwo fight variables
    PTwoheadDotStartX = screenWidth-50;
    AI = 1;
    PTwofightWalkCounter = 0;
    PTwofightWalkRightGo = -1;
    PTwofightWalkLeftGo = -1;
    PTwoguardOn = -1;
    PTwopunchCounter = 0;
    PTwothrowCounter = 0;
    PTwowalkSpeed = walkSpeed;
    PTwoHP = HP;
    PTwoheadDot = [PTwoheadDotStartX, headDotStartY];
    PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-headRadius];
    PTwobottomBodyDot = [PTwotopBodyDot(1), PTwotopBodyDot(2)-20];
    %right elbow
    PTwoelbowDotOne = [PTwotopBodyDot(1)+3,PTwotopBodyDot(2)-10];
    %left elbow
    PTwoelbowDotTwo = [PTwotopBodyDot(1)-3,PTwotopBodyDot(2)-10];
    %right hand
    PTwohandDotOne = [PTwotopBodyDot(1)+6,PTwobottomBodyDot(2)];
    %left hand
    PTwohandDotTwo = [PTwotopBodyDot(1)-6,PTwobottomBodyDot(2)];
    %right knee
    PTwokneeDotOne = [PTwobottomBodyDot(1)+3,PTwobottomBodyDot(2)-10];
    %left hand
    PTwokneeDotTwo = [PTwotopBodyDot(1)-3,PTwobottomBodyDot(2)-10];
    %right foot
    PTwofootDotOne = [PTwobottomBodyDot(1)+6,PTwobottomBodyDot(2)-20];
    %left foot
    PTwofootDotTwo = [PTwobottomBodyDot(1)-6,PTwobottomBodyDot(2)-20];
    
    %the game variable
    Game = 0;
    %start GUI
    GUI = figure();
    axis([0 screenWidth 0 screenHeight]);
    text(screenWidth/4.5,screenHeight/3,'Play DODGER','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openMissleRulesGUI)
    text(3*screenWidth/4.8,screenHeight/3,'Play CAGE FIGHTER','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightRulesGUI)
    text((screenWidth/2)-100,screenHeight/2,'Welcome to Stick Figure Adventures','FontUnits','normalized','FontSize',0.05);
    text((screenWidth/2)-100,screenHeight/4,'HINT: Make sure your Caps Lock is off','FontUnits','normalized','FontSize',0.03);
    text((screenWidth/2)-100,screenHeight/5,'HINT: Press v to pause','FontUnits','normalized','FontSize',0.03);


    %--------------------Interactive Functions-----------------------------
    
    %Game GUIs
    function openFightRulesGUI(src,event)
        delete(GUI)
        figure('ButtonDownFcn',@openFightGUI)
        axis([0 screenWidth 0 screenHeight]);
        text(10,screenHeight-50,'Player One','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
        text(10,screenHeight-90,'s -> move right','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
        text(10,screenHeight-110,'a -> move left','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
        text(10,screenHeight-130,'w -> punch','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
        text(10,screenHeight-150,'q -> guard','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
        text(10,screenHeight-170,'e -> throw','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)  
        text(200,screenHeight-50,'Player Two','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
        text(200,screenHeight-90,'l -> move right','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
        text(200,screenHeight-110,'k -> move left','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
        text(200,screenHeight-130,'o -> punch','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
        text(200,screenHeight-150,'p -> guard','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI) 
        text(200,screenHeight-170,'i -> throw','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)  
        text(100,screenHeight-190,'Click to Begin','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openFightGUI)
    end
    function openMissleRulesGUI(src,event)
        delete(GUI)
        figure('ButtonDownFcn',@openMissleGUI)
        axis([0 screenWidth 0 screenHeight]);
        text(screenWidth/2,screenHeight-90,'s -> move right','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openMissleGUI)
        text(screenWidth/2,screenHeight-110,'a -> move left','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openMissleGUI)
        text(screenWidth/2,screenHeight-130,'w -> jump','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openMissleGUI)
        text(screenWidth/2,screenHeight-150,'Click to begin','FontUnits','normalized','FontSize',0.04,'ButtonDownFcn',@openMissleGUI)
    end
    
    function openMissleGUI(src,event)
        close()
        GUI = figure('KeyPressFcn',@keyDown,'KeyReleaseFcn',@keyUp,'CloseRequestFcn',@close);
        Game = 1;
        playMissle();
    end
    function openFightGUI(src,event)
        close()
        GUI = figure('KeyPressFcn',@keyDown,'KeyReleaseFcn',@keyUp,'CloseRequestFcn',@close);
        Game = 1;
        playFight();
    end
        
    %triggers when a screen is cloed
    function close(~,event)
        %this is here to make sure the movement loop exits when the figure
        %closes
        delete(GUI);
        walkRightGo = -1;
        walkLeftGo = -1;
        jumpGo = -1;
        missleGo = -1;
        Game = 0;
    end

    % all keyboard commands only work when Game == 1
    function keyDown(~,event)
        %quit the game loop
        if event.Character == 'v' && Game == 1;
            clear();
            axis([0 screenWidth 0 screenHeight]);        
            text(screenWidth/3,screenHeight/2,'Paused. Press p to resume')
            pause;
            clear();
            draw();
        %increase pause time
        elseif event.Character == 'b' && Game == 1;
            pauseTime = pauseTime + 0.1;
        %walk right
        elseif event.Character == 's' && (headDot(2) == headDotStartY) && Game == 1 && punchCounter == 0 && throwCounter == 0 && guardOn <= 0 && PTwothrowCounter == 0;
            if missleGo == 1;
                bodyPositionCounter = 0;
                walkRightGo = 1;
                walkLeftGo = -1;
                jumpGo = -1;
            elseif fightGo == 1;
                fightWalkCounter = 0;
                fightWalkRightGo = 1;
                fightWalkLeftGo = -1;
            end
        %walk lefte
        elseif event.Character == 'a' && (headDot(2) == headDotStartY) && Game == 1 && punchCounter == 0 && throwCounter == 0 && guardOn <= 0 && PTwothrowCounter == 0;
            if missleGo == 1;
                bodyPositionCounter = 0;
                walkLeftGo = 1;
                walkRightGo = -1;
                jumpGo = -1;
            elseif fightGo == 1;
                fightWalkCounter = 0;
                fightWalkLeftGo = 1;
                fightWalkRightGo = -1;
            end
        %load and jump
        elseif event.Character == 'w' && (headDot(2) == headDotStartY) && Game == 1 && missleGo == 1;
            %since the entire jump windup takes place during one run
            %through of the loop, we will advance the missles on each step
            %of the windup
            walkRightGo = -1;
            walkLeftGo = -1;
            headDot(2) = headDotStartY - 10;
            jumpOne();
            moveMissle();
            clear();
            draw();
            headDot(2) = headDotStartY - 20;
            jumpTwo();
            moveMissle()
            clear();
            draw();
            headDot(2) = headDotStartY - 30;
            jumpThree();
            moveMissle();
            clear();
            draw();
            headDot(2) = headDotStartY - 20;
            jumpTwo();
            moveMissle();
            clear();
            draw();
            headDot(2) = headDotStartY - 10;
            jumpOne();
            moveMissle();
            clear();
            draw();
            headDot(2) = headDotStartY;
            moveMissle()
            stand();
            clear();
            draw();
            jumpSpeed = jumpMaxSpeed;
            walkSpeed = 0;
            bodyPositionCounter = 4;
            jumpGo = 1;
        %guard
        elseif event.Character == 'q' && fightGo == 1 && punchCounter == 0 && throwCounter == 0 && guardOn <= 0 && PTwothrowCounter == 0;
            fightWalkRightGo = -1;
            fightWalkLeftGo = -1;
            guardOn = 1;
        %punch
        elseif event.Character == 'w' && fightGo == 1 && guardOn == -1 && punchCounter == 0 && throwCounter == 0 && PTwothrowCounter == 0;
            fightWalkRightGo = -1;
            fightWalkLeftGo = -1;
            punchCounter = 1;
        %throw
        elseif event.Character == 'e' && fightGo == 1 && guardOn == -1 && ((PTwoguardOn == -1 && (headDot(1) + 12 > PTwoheadDot(1))) || ( (PTwoguardOn == 1 || PTwopunchCounter > 0) && (headDot(1) + 25 > PTwoheadDot(1)))) && throwCounter == 0 && punchCounter == 0 && PTwothrowCounter == 0;
            fightWalkCounter = 0;
            fightWalkRightGo = -1;
            fightWalkLeftGo = -1;
            PTwopunchCounter = 0;
            PTwofightWalkCounter = 0;
            PTwofightWalkRightGo = -1;
            PTwofightWalkLeftGo = -1;
            throwCounter = 1;
        %enemy walk right
        elseif event.Character == 'l' && fightGo == 1 && AI <= 0 && PTwopunchCounter == 0 && PTwothrowCounter == 0 && PTwoguardOn <= 0 && throwCounter == 0;
            if fightGo == 1;
                PTwofightWalkCounter = 0;
                PTwofightWalkRightGo = 1;
                PTwofightWalkLeftGo = -1;
            end
        %enemy walk left
        elseif event.Character == 'k' && fightGo == 1 && AI <= 0 && PTwopunchCounter == 0 && PTwothrowCounter == 0 && PTwoguardOn <= 0 && throwCounter == 0;
            if fightGo == 1;
                PTwofightWalkCounter = 0;
                PTwofightWalkLeftGo = 1;
                PTwofightWalkRightGo = -1;
            end
        %enemy punch
        elseif event.Character == 'o' && fightGo == 1 && PTwoguardOn == -1 && PTwopunchCounter == 0 && PTwothrowCounter == 0 && AI <= 0 && throwCounter == 0;
            PTwofightWalkRightGo = -1;
            PTwofightWalkLeftGo = -1;
            PTwopunchCounter = 1;
        %enemy guard
        elseif event.Character == 'p' && fightGo == 1 && AI <= 0 && PTwopunchCounter == 0 && PTwothrowCounter == 0 && PTwoguardOn <= 0 && throwCounter == 0;
            PTwofightWalkRightGo = -1;
            PTwofightWalkLeftGo = -1;
            PTwoguardOn = 1;
        %enemy throw
        elseif event.Character == 'i' && fightGo == 1 && ((guardOn == -1 && (headDot(1) + 12 > PTwoheadDot(1))) || ((guardOn == 1 || punchCounter >0) && (headDot(1) + 25 > PTwoheadDot(1)))) && AI <= 0 && PTwothrowCounter == 0 && PTwopunchCounter == 0 && PTwoguardOn <= 0 && throwCounter == 0;
            punchCounter = 0;
            fightWalkCounter = 0;
            fightWalkRightGo = -1;
            fightWalkLeftGo = -1;
            PTwofightWalkCounter = 0;
            PTwofightWalkRightGo = -1;
            PTwofightWalkLeftGo = -1;
            PTwothrowCounter = 1;
        elseif event.Character == 'n';
            AI = AI*-1;
            if AI == -1;
                PTwopunchCounter = 0;
                PTwoguardOn = -1;
                PTwofightWalkCounter = 0;
                PTwofightWalkLeftGo = -1;
                PTwofightWalkRightGo = -1;
            end
        end
    end

    % all keyboard commands only work when Game == 1
    function keyUp(~,event)
        %stop walk right
        if event.Character == 's' && Game == 1;
            if missleGo == 1;
                %bodyPositionCounter = 0;
                %walkRightGo = -1;
                %walkLeftGo = -1;
                %clear();
                %stand();
                %draw();
            elseif fightGo == 1;
                fightWalkCounter = 0;
                fightWalkRightGo = -1;
                fightWalkLeftGo = -1;
            end 
        %stop walk left
        elseif event.Character == 'a' && Game == 1;
            %the comments below can be removed to take away the constant
            %movement from the missle game
            if missleGo == 1;
                %bodyPositionCounter = 0;
                %walkLeftGo = -s1;
                %walkRightGo = -1;
                %clear();
                %stand();
                %draw();
            elseif fightGo == 1;
                fightWalkCounter = 0;
                fightWalkRightGo = -1;
                fightWalkLeftGo = -1;
            end
        %stop guard
        elseif event.Character == 'q' && fightGo == 1;
            guardOn = -1;
        %enemy stop walk right
        elseif event.Character == 'l' && fightGo == 1;
            if fightGo == 1;
                PTwofightWalkCounter = 0;
                PTwofightWalkRightGo = -1;
                PTwofightWalkLeftGo = -1;
            end
        %enemy stop walk left
        elseif event.Character == 'k' && fightGo == 1;
            if fightGo == 1;
                PTwofightWalkCounter = 0;
                PTwofightWalkLeftGo = -1;
                PTwofightWalkRightGo = -1;
            end
        %enemy stop guard
        elseif event.Character == 'p' && fightGo == 1;
            PTwoguardOn = -1;
        end
    end

    %----------------------Missle Functions--------------------------------

    %begin missle Game
    function playMissle
        missleGo=1;
        gameLoop();
    end

    %add another missle to the screen, if counter is at the length of the
    %missle Cell Array, then reset the array and the counter
    function addMissle
        %adds the missle to the array
        %first/second parameters determine the x/y coordinates of the
        %missle
        %the third missle parameter determines whether the missle will
        %travel straight (1) or sinusoidally (2)
        %the fourth parameter determines missle speed
        %the fifth parameter is the initial y position
        if missleGo > 0;
            startingY = (headDotStartY - (50-randi(130)));
            missleCellArray{missleCellCounter} = [screenWidth+5+randi(50),startingY,randi(2),missleSpeed - 2 + randi(4),startingY];
            missleCellCounter = missleCellCounter + 1;
            totalMissleCounter = totalMissleCounter + 1;
            %if the number of missles fired is greater than the spaces in the
            %array, the array is cleared and the counter reset
            if missleCellCounter >= length(missleCellArray);
                missleCellCounter = 1;
                missleCellArray = cell(1,30);
                missleSpeed = missleSpeed*1.5;
            end
        end
    end

    %make all existing missles move, change missleBreakCounter, and check
    %missle collisions
    function moveMissle
        if missleGo > 0;
            missleBreakCounter = missleBreakCounter - 1;
            for cellIndex = 1:length(missleCellArray);
                if isempty(missleCellArray{cellIndex});
                    break
                else
                    missle = missleCellArray{cellIndex};
                    %sinusoidal travel
                    if missle(3) == 2;
                        %missle(x) = missle(x) + missleSpeed
                        missle(1) = missle(1) - missle(4);
                        %missle(y) = YstartPosition + sin(missle(x)) or y = A+sin(x)
                        missle(2) = missle(2) + randi(10)*sin(missle(1)/5);
                    end
                    %linear travel
                    if missle(3) == 1;
                        missle(1) = missle(1) - missle(4); 
                    end
                    %place the reset missle vector back into the cell array
                    missleCellArray{cellIndex} = missle;
                end
            end
            %since missle movement is advanced in some other places, we can
            %code in the missle collisions here
            checkCollision()
        end
    end
    
    %In the missle Game, checks for collisions - missles need to hit the head or pass through
    %the line of the vertebrate to do damage - jump glancing arms or legs
    %wont do it
    function checkCollision 
        for index = 1:length(missleCellArray);
            if isempty(missleCellArray{index}) || flash == 1;
                break
            else
                missle = missleCellArray{index};
                %first check if missle is on line of vertebrate
                if (missle(1) + missleRadius > headDot(1)) && (missle(1) - missleRadius < headDot(1)) && (missle(2) < headDot(2) + headRadius) && (missle(2) > footDotOne(2));
                    HP = HP - 1;
                    flash = 1;
                %then if missle is in line with the head
                elseif (missle(1) < headDot(1) + headRadius) && (missle(1) > headDot(1) - headRadius) && (missle(2) < headDot(2) + headRadius) && (missle(2) > headDot(2) - headRadius)
                    HP = HP - 1;
                    flash = 1;
                end
            end
            if HP == 0;
                Game = 0;
            end
        end
    end

    %the folloing three functions cause a cycling through the drawing
    %functions, and also call move
    
    function walkRight
        walkSpeed = walkSpeedR;
        move()
        if bodyPositionCounter == 0;
            walkRightOne();
            bodyPositionCounter = 1;
        elseif bodyPositionCounter == 1;
            walkRightTwo();
            bodyPositionCounter = 2;
        elseif bodyPositionCounter == 2;
            walkRightThree();
            bodyPositionCounter = 3;
        elseif bodyPositionCounter == 3;
            walkRightOne();
            bodyPositionCounter = 1;
        end
    end

    function walkLeft
        walkSpeed = walkSpeedL;
        move();
        if bodyPositionCounter == 0;
            walkLeftOne();
            bodyPositionCounter = -1;
        elseif bodyPositionCounter == -1;
            walkLeftTwo();
            bodyPositionCounter = -2;
        elseif bodyPositionCounter == -2;
            walkLeftThree();
            bodyPositionCounter = -3;
        elseif bodyPositionCounter == -3;
            walkLeftOne();
            bodyPositionCounter = -1;
        end
    end
    
    function jump
        move();
        if jumpSpeed > 0;
            if bodyPositionCounter == 4;
                jumpOne();
                bodyPositionCounter = 5;
            elseif bodyPositionCounter == 5;
                jumpTwo();
                bodyPositionCounter = 6;
            else
                jumpThree();
                bodyPositionCounter = 7;
            end
        elseif jumpSpeed < 0 || jumpSpeed == 0;
            if bodyPositionCounter == 7;
                jumpThree();
                bodyPositionCounter = 6;
            elseif bodyPositionCounter == 6;
                jumpTwo();
                bodyPositionCounter = 5;
            else
                jumpOne();
                bodyPositionCounter = 4;
            end
        end
        
    end
    
    %the following functions draw the man in different positions - they are
    %called by the above functions
    
    function jumpOne
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+7,topBodyDot(2)-7];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-7,topBodyDot(2)-7];
        %right hand
        handDotOne = [topBodyDot(1)+10,bottomBodyDot(2)+10];
        %left hand
        handDotTwo = [topBodyDot(1)-10,bottomBodyDot(2)+10];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)+1];
        %left hand
        kneeDotTwo = [topBodyDot(1)-3,bottomBodyDot(2)+1];
        %right foot
        footDotOne = [bottomBodyDot(1)+6,bottomBodyDot(2)-9];
        %left foot
        footDotTwo = [bottomBodyDot(1)-6,bottomBodyDot(2)-9];
    end

    function jumpTwo
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+10,topBodyDot(2)];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-10,topBodyDot(2)];
        %right hand
        handDotOne = [topBodyDot(1)+13,topBodyDot(2)];
        %left hand
        handDotTwo = [topBodyDot(1)-13,topBodyDot(2)];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)+8];
        %left hand
        kneeDotTwo = [topBodyDot(1)-3,bottomBodyDot(2)+8];
        %right foot
        footDotOne = [bottomBodyDot(1)+7,bottomBodyDot(2)-2];
        %left foot
        footDotTwo = [bottomBodyDot(1)-7,bottomBodyDot(2)-2];
    end

    function jumpThree
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+7,topBodyDot(2)+4];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-7,topBodyDot(2)+4];
        %right hand
        handDotOne = [topBodyDot(1)+10,topBodyDot(2)+6];
        %left hand
        handDotTwo = [topBodyDot(1)-10,topBodyDot(2)+6];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)+10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-3,bottomBodyDot(2)+10];
        %right foot
        footDotOne = [bottomBodyDot(1)+8,bottomBodyDot(2)];
        %left foot
        footDotTwo = [bottomBodyDot(1)-8,bottomBodyDot(2)];
    end

    function walkRightOne
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+1,topBodyDot(2)-10];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-1.5,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+3.5,bottomBodyDot(2)+2];
        %left hand
        handDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)+1.5];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1)-4,bottomBodyDot(2)-17];
    end
    
    function walkRightTwo
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+1,topBodyDot(2)-10];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-1,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+6,topBodyDot(2)-18];
        %left hand
        handDotTwo = [topBodyDot(1)+1,bottomBodyDot(2)+2];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-0.5,bottomBodyDot(2)-7];
        %right foot
        footDotOne = [bottomBodyDot(1),bottomBodyDot(2)-18];
        %left foot
        footDotTwo = [bottomBodyDot(1)-2,bottomBodyDot(2)-17];
    end

    function walkRightThree
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1),topBodyDot(2)-10];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+0.5,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+3,topBodyDot(2)-18];
        %left hand
        handDotTwo = [topBodyDot(1)+1,bottomBodyDot(2)+2];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+1.5,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)+0.5,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)-1,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1),bottomBodyDot(2)-17];
    end
    
    function walkLeftOne
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)-1,topBodyDot(2)-10];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+1.5,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)-3.5,bottomBodyDot(2)+2];
        %left hand
        handDotTwo = [topBodyDot(1)+1,bottomBodyDot(2)-1.5];
        %right knee
        kneeDotOne = [bottomBodyDot(1)-2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)+1,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)-3,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1)+4,bottomBodyDot(2)-17];
    end
    
    function walkLeftTwo
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)-1,topBodyDot(2)-10];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+1,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)-6,topBodyDot(2)-18];
        %left hand
        handDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)+2];
        %right knee
        kneeDotOne = [bottomBodyDot(1)-2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)+0.5,bottomBodyDot(2)-7];
        %right foot
        footDotOne = [bottomBodyDot(1),bottomBodyDot(2)-18];
        %left foot
        footDotTwo = [bottomBodyDot(1)+2,bottomBodyDot(2)-17];
    end

    function walkLeftThree
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1),topBodyDot(2)-10];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-0.5,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)-3,topBodyDot(2)-18];
        %left hand
        handDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)+2];
        %right knee
        kneeDotOne = [bottomBodyDot(1)-1.5,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-0.5,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+1,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1),bottomBodyDot(2)-17];
    end

    %--------------------------Fight Functions-----------------------------

    function playFight
        fightGo = 1;
        gameLoop();
    end

    function checkPunch (punchingPlayer)
        if punchingPlayer == 1 && (PTwoheadDot(1) - 10) < handDotOne(1) && PTwoguardOn <= 0;
            PTwoHP = PTwoHP - 1;
            PTworecoil()
            PTwofightWalkCounter = 0;
        elseif punchingPlayer == 2 && (headDot(1) + 10) > PTwohandDotOne(1) && guardOn <= 0;
            HP = HP - 1;
            recoil()
            fightWalkCounter = 0;
        end
    end

    %you have 5 lives, the goal is to KILL the other guy as many times as
    %possible before getting killed
    
    %in fight stance, you are vulnerable to getting hit -> but you can
    %move/punch
    %in guard stance -> you cant hit or move -> but you can guard (maybe a
    %time limit?)
    %punch 'stance' - punch is fired - registered as hitting if it makes
    %contact with opponent     
    
    %for damage -> when the snapshot of the extended full punch is shown -
    %if opponent's headDot-headRadius is between the thrower's vertebrate
    %and hand -> it counts as having done damage
    
    function fightStanceOne
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+3,topBodyDot(2)-5];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+2,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+8,topBodyDot(2)+2];
        %left hand
        handDotTwo = [topBodyDot(1)+6,bottomBodyDot(2)+14];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1)-4,bottomBodyDot(2)-17];
    end
    
    function fightStanceTwo
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+3,topBodyDot(2)-5];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+2,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+8,topBodyDot(2)+2];
        %left hand
        handDotTwo = [topBodyDot(1)+6,bottomBodyDot(2)+14];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-0.5,bottomBodyDot(2)-7];
        %right foot
        footDotOne = [bottomBodyDot(1),bottomBodyDot(2)-18];
        %left foot
        footDotTwo = [bottomBodyDot(1)-2,bottomBodyDot(2)-17];
    end

    function fightStanceThree
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+3,topBodyDot(2)-5];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+2,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+8,topBodyDot(2)+2];
        %left hand
        handDotTwo = [topBodyDot(1)+6,bottomBodyDot(2)+14];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+1.5,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)+0.5,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)-1,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1),bottomBodyDot(2)-17];
    end
    
    function guardStance
        %right elbow
        elbowDotOne = [topBodyDot(1)+3,topBodyDot(2)-1];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+5,topBodyDot(2)-3];
        %right hand
        handDotOne = [topBodyDot(1)+9,topBodyDot(2)+6];
        %left hand
        handDotTwo = [topBodyDot(1)+7,topBodyDot(2)+6];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-0.5,bottomBodyDot(2)-7];
        %right foot
        footDotOne = [bottomBodyDot(1),bottomBodyDot(2)-18];
        %left foot
        footDotTwo = [bottomBodyDot(1)-2,bottomBodyDot(2)-17];
    end

    function punchWindup
        topBodyDot = [headDot(1), headDot(2)-5];
        %right elbow
        elbowDotOne = [topBodyDot(1)-5,topBodyDot(2)-7];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+3,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+3,topBodyDot(2)-5];
        %left hand
        handDotTwo = [topBodyDot(1)+7,bottomBodyDot(2)+14];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1)-4,bottomBodyDot(2)-17];
    end

    function fullPunch
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+10,topBodyDot(2)];
        %left elbow
        elbowDotTwo = [topBodyDot(1),topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+15,topBodyDot(2)];
        %left hand
        handDotTwo = [topBodyDot(1)+4,bottomBodyDot(2)+14];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1)-4,bottomBodyDot(2)-17];
    end

    function fightWalk
        %walk right
        if fightWalkRightGo == 1 && fightWalkLeftGo == -1 && guardOn == -1 && punchCounter == 0 && (headDot(1) + 8 < PTwoheadDot(1) || fightGo <= 0) && throwCounter ==0 && PTwothrowCounter == 0;
            walkSpeed = abs(walkSpeed);
            move();
            if fightWalkCounter == 0;
                fightStanceOne();
                fightWalkCounter = 1;
            elseif fightWalkCounter == 1;
                fightStanceTwo();
                fightWalkCounter = 2;
            elseif fightWalkCounter == 2;
                fightStanceThree();
                fightWalkCounter = 3;
            elseif fightWalkCounter == 3;
                fightStanceOne();
                fightWalkCounter = 1;
            end
        elseif fightWalkRightGo == -1 && fightWalkLeftGo == 1 && guardOn == -1 && punchCounter == 0 && throwCounter ==0 && PTwothrowCounter == 0;
            walkSpeed = -1*abs(walkSpeed);
            move();
            if fightWalkCounter == 0;
                fightStanceThree();
                fightWalkCounter = 1;
            elseif fightWalkCounter == 1;
                fightStanceTwo();
                fightWalkCounter = 2;
            elseif fightWalkCounter == 2;
                fightStanceOne();
                fightWalkCounter = 3;
            elseif fightWalkCounter == 3;
                fightStanceThree();
                fightWalkCounter = 1;
            end 
        elseif fightWalkRightGo == -1 && fightWalkLeftGo == -1 && guardOn == 1 && punchCounter == 0 && throwCounter ==0 && PTwothrowCounter == 0;
            guardStance();
        elseif punchCounter > 0 && guardOn == -1 && throwCounter == 0 && PTwothrowCounter == 0;
            if punchCounter == 1;
                punchWindup();
                punchCounter = 2;
            elseif punchCounter == 2;
                fightStanceOne();
                punchCounter = 3;
            elseif punchCounter == 3;
                fullPunch();
                %punching variable detects whether or not the character is
                %dealing damage
                checkPunch(1);
                punchCounter = 0;
            end
        elseif throwCounter > 0 && guardOn == -1 && punchCounter == 0 && PTwothrowCounter == 0;
            if throwCounter == 1;
                throwImageOne();
                throwCounter = 2;
            elseif throwCounter == 2;
                throwImageTwo();
                throwCounter = 3;
                pause(0.05);
            elseif throwCounter == 3;
                throwImageThree();
                throwCounter = 4;
                pause(0.05);
            elseif throwCounter == 4;
                %note that there is a pause here to show the throw
                PTwoHP = PTwoHP - 1;
                pause(0.5);
                headDot(2) = headDotStartY;
                PTwoheadDot = [headDot(1) + 30, headDot(2)];
                fightStanceOne();
                PTwofightStanceOne();
                throwCounter = 0;
            end 
        %this else returns us to the starting fight stance position
        elseif guardOn == -1 && throwCounter == 0 && PTwothrowCounter == 0 && punchCounter == 0;
            fightStanceOne();
        end
    end

    function recoil
        %headDot moves back (moves body)
        if headDot(1) - 20 > 0;
            headDot(1) = headDot(1) - 20;
        else
            headDot(1) = 1;
        end
        %arm splayed out position
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+3,topBodyDot(2)];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-3,topBodyDot(2)];
        %right hand
        handDotOne = [topBodyDot(1)+8,topBodyDot(2)+5];
        %left hand
        handDotTwo = [topBodyDot(1)-8,bottomBodyDot(2)+5];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1)-4,bottomBodyDot(2)-17];
        clear()
        draw()
    end

    function throwImageOne
        %spacing
        headDot(1) = PTwoheadDot(1) - 10;
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+3,topBodyDot(2)-5];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+2,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+8,topBodyDot(2)+2];
        %left hand
        handDotTwo = [topBodyDot(1)+6,bottomBodyDot(2)+14];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1)-4,bottomBodyDot(2)-17];
        
        %PTwo Positions
        PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-5];
        PTwobottomBodyDot = [PTwotopBodyDot(1), PTwotopBodyDot(2)-20];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)-3,PTwotopBodyDot(2)-5];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)-2,PTwotopBodyDot(2)-10];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-8,PTwotopBodyDot(2)+2];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-6,PTwobottomBodyDot(2)+14];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-2,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+1,PTwobottomBodyDot(2)-10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)-3,PTwobottomBodyDot(2)-17];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+4,PTwobottomBodyDot(2)-17];
    end
    
    function throwImageTwo
        %spacing
        headDot = headDot +  [-20,-20];
        topBodyDot = [headDot(1)+5, headDot(2)];
        bottomBodyDot = [topBodyDot(1)+18, topBodyDot(2)-2];
        %right elbow
        elbowDotOne = [topBodyDot(1)+8,topBodyDot(2)+5];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+8,topBodyDot(2)-5];
        %right hand
        handDotOne = [topBodyDot(1)+12,topBodyDot(2)-3];
        %left hand
        handDotTwo = [topBodyDot(1)+6,topBodyDot(2)-13];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-3,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+6,bottomBodyDot(2)-20];
        %left foot
        footDotTwo = [bottomBodyDot(1)-6,bottomBodyDot(2)-20];
        
        %PTwo Positions
        PTwoheadDot = headDot + [7,-15];
        PTwotopBodyDot = [PTwoheadDot(1)+3, PTwoheadDot(2)+4];
        PTwobottomBodyDot = [PTwotopBodyDot(1)+12, PTwotopBodyDot(2)+12];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1),PTwotopBodyDot(2)+10];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)+10,PTwotopBodyDot(2)];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1),PTwotopBodyDot(2)+20];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)+20,PTwobottomBodyDot(2)];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)+10,PTwobottomBodyDot(2)];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1),PTwobottomBodyDot(2)+10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)+20,PTwobottomBodyDot(2)];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1),PTwobottomBodyDot(2)+20];
    end

    function throwImageThree
        %prevents throws out of the ring
        if headDot(1) - 50 < 0;
            headDot(1) = headDot(1) + 50;
            PTwoheadDot(1) = PTwoheadDot(1) + 50;
        end
        headDot = headDot +  [10,10];
        topBodyDot = [headDot(1)+3, headDot(2)-4];
        bottomBodyDot = [topBodyDot(1)+12, topBodyDot(2)-12];
        %right elbow
        elbowDotOne = [topBodyDot(1),topBodyDot(2)-10];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-3,topBodyDot(2)-7];
        %right hand
        handDotOne = [topBodyDot(1)-10,topBodyDot(2)-10];
        %left hand
        handDotTwo = [topBodyDot(1)-9,topBodyDot(2)-7];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-3,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+6,bottomBodyDot(2)-20];
        %left foot
        footDotTwo = [bottomBodyDot(1)-6,bottomBodyDot(2)-20];
      
        PTwoheadDot = [footDotTwo(1)-10,footDotTwo(2)+5];
        PTwotopBodyDot = [PTwoheadDot(1)-5,PTwoheadDot(2)];
        PTwobottomBodyDot = [PTwotopBodyDot(1)-20,PTwotopBodyDot(2)];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)-10,PTwotopBodyDot(2)+3];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)-10,PTwotopBodyDot(2)-3];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-20,PTwotopBodyDot(2)+6];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-20,PTwobottomBodyDot(2)-6];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-10,PTwobottomBodyDot(2)+3];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)-10,PTwobottomBodyDot(2)-3];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)-20,PTwobottomBodyDot(2)+6];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)-20,PTwobottomBodyDot(2)-6];

    end

    
    %%%%%%%%%Player Two Fight Functions%%%%%%%%%
    
    function PTwofightStanceOne
        PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-5];
        PTwobottomBodyDot = [PTwotopBodyDot(1), PTwotopBodyDot(2)-20];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)-3,PTwotopBodyDot(2)-5];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)-2,PTwotopBodyDot(2)-10];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-8,PTwotopBodyDot(2)+2];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-6,PTwobottomBodyDot(2)+14];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-2,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+1,PTwobottomBodyDot(2)-10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)-3,PTwobottomBodyDot(2)-17];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+4,PTwobottomBodyDot(2)-17];
    end
    
    function PTwofightStanceTwo
        PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-5];
        PTwobottomBodyDot = [PTwotopBodyDot(1), PTwotopBodyDot(2)-20];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)-3,PTwotopBodyDot(2)-5];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)-2,PTwotopBodyDot(2)-10];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-8,PTwotopBodyDot(2)+2];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-6,PTwobottomBodyDot(2)+14];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-2,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+0.5,PTwobottomBodyDot(2)-7];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1),PTwobottomBodyDot(2)-18];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+2,PTwobottomBodyDot(2)-17];
    end

    function PTwofightStanceThree
        PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-5];
        PTwobottomBodyDot = [PTwotopBodyDot(1), PTwotopBodyDot(2)-20];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)-3,PTwotopBodyDot(2)-5];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)-2,PTwotopBodyDot(2)-10];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-8,PTwotopBodyDot(2)+2];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-6,PTwobottomBodyDot(2)+14];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-1.5,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)-0.5,PTwobottomBodyDot(2)-10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)+1,PTwobottomBodyDot(2)-17];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1),PTwobottomBodyDot(2)-17];
    end
        
    function PTwoguardStance
        PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-5];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)-3,PTwotopBodyDot(2)-1];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)-5,PTwotopBodyDot(2)-3];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-9,PTwotopBodyDot(2)+6];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-7,PTwotopBodyDot(2)+6];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-2,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+0.5,PTwobottomBodyDot(2)-7];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1),PTwobottomBodyDot(2)-18];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+2,PTwobottomBodyDot(2)-17];
    end

    function PTwopunchWindup
        PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-5];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)+5,PTwotopBodyDot(2)-7];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)-3,PTwotopBodyDot(2)-10];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-3,PTwotopBodyDot(2)-5];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-7,PTwobottomBodyDot(2)+14];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-2,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+1,PTwobottomBodyDot(2)-10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)-3,PTwobottomBodyDot(2)-17];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+4,PTwobottomBodyDot(2)-17];
    end

    function PTwofullPunch
        PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-5];
        PTwobottomBodyDot = [PTwotopBodyDot(1),PTwotopBodyDot(2)-20];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)-10,PTwotopBodyDot(2)];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1),PTwotopBodyDot(2)-10];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-15,PTwotopBodyDot(2)];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-4,PTwobottomBodyDot(2)+14];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-2,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+1,PTwobottomBodyDot(2)-10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)-3,PTwobottomBodyDot(2)-17];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+4,PTwobottomBodyDot(2)-17];
    end
    
    function PTwofightWalk
        %walking right
        if PTwofightWalkRightGo == 1 && PTwofightWalkLeftGo == -1 && PTwoguardOn == -1 && PTwopunchCounter == 0 && throwCounter == 0 && PTwothrowCounter == 0;
            PTwowalkSpeed = abs(walkSpeed);
            PTwomove();
            if PTwofightWalkCounter == 0;
                PTwofightStanceOne();
                PTwofightWalkCounter = 1;
            elseif PTwofightWalkCounter == 1;
                PTwofightStanceTwo();
                PTwofightWalkCounter = 2;
            elseif PTwofightWalkCounter == 2;
                PTwofightStanceThree();
                PTwofightWalkCounter = 3;
            elseif PTwofightWalkCounter == 3;
                PTwofightStanceOne();
                PTwofightWalkCounter = 1;
            end
        %walking left
        elseif PTwofightWalkRightGo == -1 && PTwofightWalkLeftGo == 1 && PTwoguardOn == -1 && PTwopunchCounter == 0 && (headDot(1) + 8 < PTwoheadDot(1)) && throwCounter ==0 && PTwothrowCounter == 0;
            PTwowalkSpeed = -1*abs(walkSpeed);
            PTwomove();
            if PTwofightWalkCounter == 0;
                PTwofightStanceThree();
                PTwofightWalkCounter = 1;
            elseif PTwofightWalkCounter == 1;
                PTwofightStanceTwo();
                PTwofightWalkCounter = 2;
            elseif PTwofightWalkCounter == 2;
                PTwofightStanceOne();
                PTwofightWalkCounter = 3;
            elseif PTwofightWalkCounter == 3;
                PTwofightStanceThree();
                PTwofightWalkCounter = 1;
            end 
        elseif PTwofightWalkRightGo == -1 && PTwofightWalkLeftGo == -1 && PTwoguardOn == 1 && PTwopunchCounter == 0 && throwCounter == 0 && PTwothrowCounter == 0;
            PTwoguardStance();
        elseif PTwopunchCounter > 0 && PTwoguardOn == -1 && throwCounter == 0 && PTwothrowCounter == 0;
            if PTwopunchCounter == 1;
                PTwopunchWindup();
                PTwopunchCounter = 2;
            elseif PTwopunchCounter == 2;
                PTwofightStanceOne();
                PTwopunchCounter = 3;
            elseif PTwopunchCounter == 3;
                %punching variable detects whether or not the character is
                %dealing damage
                PTwofullPunch();
                checkPunch(2);
                PTwopunchCounter = 0;
            end
        elseif PTwothrowCounter > 0 && PTwoguardOn == -1 && PTwopunchCounter == 0 && throwCounter == 0;
            if PTwothrowCounter == 1;
                PTwothrowImageOne();
                PTwothrowCounter = 2;
            elseif PTwothrowCounter == 2;
                PTwothrowImageTwo();
                PTwothrowCounter = 3;
                pause(0.05);
            elseif PTwothrowCounter == 3;
                PTwothrowImageThree();
                PTwothrowCounter = 4;
                pause(0.05);
            elseif PTwothrowCounter == 4;
                %note that there is a pause here to show the throw
                HP = HP - 1;
                pause(0.5);
                PTwoheadDot(2) = headDotStartY;
                headDot = [PTwoheadDot(1) - 30, PTwoheadDot(2)];
                fightStanceOne();
                PTwofightStanceOne();
                PTwothrowCounter = 0;
            end 
        %this else returns us to the starting fight stance position
        elseif PTwoguardOn == -1 && throwCounter == 0 && PTwothrowCounter == 0;
            PTwofightStanceOne();
        end
    end

    function PTwomove
        if PTwoheadDot(1) + PTwowalkSpeed > 0 && PTwoheadDot(1) + PTwowalkSpeed < screenWidth;
            PTwoheadDot = PTwoheadDot + [PTwowalkSpeed,0];
        end
    end

    function PTworecoil
        %headDot moves back (moves body)
        if PTwoheadDot(1) + 20 < screenWidth;
            PTwoheadDot(1) = PTwoheadDot(1) + 20;
        else
            PTwoheadDot(1) = 1;
        end
        %arm splayed out position
        PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-5];
        PTwobottomBodyDot = [PTwotopBodyDot(1), PTwotopBodyDot(2)-20];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)-3,PTwotopBodyDot(2)];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)+3,PTwotopBodyDot(2)];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-8,PTwotopBodyDot(2)+5];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)+8,PTwobottomBodyDot(2)+5];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-2,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+1,PTwobottomBodyDot(2)-10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)-3,PTwobottomBodyDot(2)-17];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+4,PTwobottomBodyDot(2)-17];
        clear()
        draw()
    end

    function PTwothrowImageOne
        %spacing
        PTwoheadDot(1) = headDot(1) + 10;
        PTwotopBodyDot = [PTwoheadDot(1), PTwoheadDot(2)-5];
        PTwobottomBodyDot = [PTwotopBodyDot(1), PTwotopBodyDot(2)-20];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)+3,PTwotopBodyDot(2)-5];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)-2,PTwotopBodyDot(2)-10];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-8,PTwotopBodyDot(2)+2];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-6,PTwobottomBodyDot(2)+14];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-2,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+1,PTwobottomBodyDot(2)-10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)-3,PTwobottomBodyDot(2)-17];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+4,PTwobottomBodyDot(2)-17];
        
        %PTwo Positions
        topBodyDot = [headDot(1),headDot(2)-5];
        bottomBodyDot = [topBodyDot(1),topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+3,topBodyDot(2)-5];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+2,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+8,topBodyDot(2)+2];
        %left hand
        handDotTwo = [topBodyDot(1)+6,bottomBodyDot(2)+14];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+2,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-1,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-17];
        %left foot
        footDotTwo = [bottomBodyDot(1)-4,bottomBodyDot(2)-17];
    end
    
    function PTwothrowImageTwo
        %spacing
        PTwoheadDot = PTwoheadDot +  [20,-20];
        PTwotopBodyDot = [PTwoheadDot(1)-5, PTwoheadDot(2)];
        PTwobottomBodyDot = [PTwotopBodyDot(1)-18, PTwotopBodyDot(2)-2];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1)-8,PTwotopBodyDot(2)+5];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)-8,PTwotopBodyDot(2)-5];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)-12,PTwotopBodyDot(2)-3];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)-6,PTwotopBodyDot(2)-13];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-3,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+3,PTwobottomBodyDot(2)-10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)-6,PTwobottomBodyDot(2)-20];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+6,PTwobottomBodyDot(2)-20];
        
        %PTwo Positions
        headDot = PTwoheadDot + [-7,-15];
        topBodyDot = [headDot(1)+3, headDot(2)+4];
        bottomBodyDot = [topBodyDot(1)-12, topBodyDot(2)+12];
        %right elbow
        elbowDotOne = [topBodyDot(1),topBodyDot(2)+10];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-10,topBodyDot(2)];
        %right hand
        handDotOne = [topBodyDot(1),topBodyDot(2)+20];
        %left hand
        handDotTwo = [topBodyDot(1)-20,bottomBodyDot(2)];
        %right knee
        kneeDotOne = [bottomBodyDot(1)-10,bottomBodyDot(2)];
        %left hand
        kneeDotTwo = [topBodyDot(1),bottomBodyDot(2)+10];
        %right foot
        footDotOne = [bottomBodyDot(1)-20,bottomBodyDot(2)];
        %left foot
        footDotTwo = [bottomBodyDot(1),bottomBodyDot(2)+20];
    end

    function PTwothrowImageThree
        %prevents throws out of the ring
        if PTwoheadDot(1) + 50 > screenWidth;
            headDot(1) = headDot(1) - 50;
            PTwoheadDot(1) = PTwoheadDot(1) - 50;
        end
        PTwoheadDot = PTwoheadDot +  [-10,10];
        PTwotopBodyDot = [PTwoheadDot(1)-3, PTwoheadDot(2)-4];
        PTwobottomBodyDot = [PTwotopBodyDot(1)-12, PTwotopBodyDot(2)-12];
        %right elbow
        PTwoelbowDotOne = [PTwotopBodyDot(1),PTwotopBodyDot(2)-10];
        %left elbow
        PTwoelbowDotTwo = [PTwotopBodyDot(1)+3,PTwotopBodyDot(2)-7];
        %right hand
        PTwohandDotOne = [PTwotopBodyDot(1)+10,PTwotopBodyDot(2)-10];
        %left hand
        PTwohandDotTwo = [PTwotopBodyDot(1)+9,PTwotopBodyDot(2)-7];
        %right knee
        PTwokneeDotOne = [PTwobottomBodyDot(1)-3,PTwobottomBodyDot(2)-10];
        %left hand
        PTwokneeDotTwo = [PTwotopBodyDot(1)+3,PTwobottomBodyDot(2)-10];
        %right foot
        PTwofootDotOne = [PTwobottomBodyDot(1)-6,PTwobottomBodyDot(2)-20];
        %left foot
        PTwofootDotTwo = [PTwobottomBodyDot(1)+6,PTwobottomBodyDot(2)-20];
        headDot = [PTwofootDotTwo(1)+10,PTwofootDotTwo(2)+5];
        topBodyDot = [headDot(1)+5,headDot(2)];
        bottomBodyDot = [topBodyDot(1)+20,topBodyDot(2)];
        %right elbow
        elbowDotOne = [topBodyDot(1)+10,topBodyDot(2)+3];
        %left elbow
        elbowDotTwo = [topBodyDot(1)+10,topBodyDot(2)-3];
        %right hand
        handDotOne = [topBodyDot(1)+20,topBodyDot(2)+6];
        %left hand
        handDotTwo = [topBodyDot(1)+20,bottomBodyDot(2)-6];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+10,bottomBodyDot(2)+3];
        %left hand
        kneeDotTwo = [topBodyDot(1)+10,bottomBodyDot(2)-3];
        %right foot
        footDotOne = [bottomBodyDot(1)+20,bottomBodyDot(2)+6];
        %left foot
        footDotTwo = [bottomBodyDot(1)+20,bottomBodyDot(2)-6];
    end

   
    %this function assesses the current game state and makes a decision
    %about what actions the AI character should take
        
    function AIChoice
        if (PTwoheadDot(1) - 15 < headDot(1)) && PTwothrowCounter == 0 && PTwopunchCounter == 0 && throwCounter == 0;
            PTwoguardOn = -1;
            fightWalkCounter = 0;
            fightWalkRightGo = -1;
            fightWalkLeftGo = -1;
            PTwofightWalkCounter = 0;
            PTwofightWalkRightGo = -1;
            PTwofightWalkLeftGo = -1;
            PTwothrowCounter = 1;
        elseif(PTwoheadDot(1) - 25 < headDot(1)) && (PTwopunchCounter == 0) && guardOn <= 0 && PTwothrowCounter == 0 && PTwoguardOn == -1 && throwCounter == 0;
            PTwoguardOn = -1;
            PTwofightWalkRightGo = -1;
            PTwofightWalkLeftGo = -1;
            PTwopunchCounter = 1;
        elseif punchCounter > 0 && (PTwoheadDot(1) - 25 < headDot(1)) && PTwothrowCounter == 0 && throwCounter == 0;
            PTwoguardOn = 1;
            PTwofightWalkCounter = 0;
            PTwofightWalkRightGo = -1;
            PTwofightWalkLeftGo = -1;
            PTwopunchCounter = 0;
        elseif (PTwoheadDot(1) - 20 < headDot(1)) && PTwothrowCounter == 0 && PTwopunchCounter == 0 && PTwoguardOn == -1 && guardOn == 1 && throwCounter == 0;
            PTwoguardOn = -1;
            fightWalkCounter = 0;
            fightWalkRightGo = -1;
            fightWalkLeftGo = -1;
            PTwofightWalkCounter = 0;
            PTwofightWalkRightGo = -1;
            PTwofightWalkLeftGo = -1;
            PTwothrowCounter = 1;
        elseif PTwopunchCounter == 0 && PTwothrowCounter == 0 && throwCounter == 0;
            if fightWalkRightGo > 0;
                PTwoguardOn = -1;
                PTwofightWalkRightGo = 1;
                PTwofightWalkLeftGo = -1;
            elseif fightWalkLeftGo <= 0 && fightWalkRightGo <= 0;
                PTwoguardOn = -1;
                PTwofightWalkLeftGo = 1;
                PTwofightWalkRightGo = -1;
            elseif fightWalkLeftGo > 0;
                PTwoguardOn = -1;
                PTwofightWalkCounter = 0;
                PTwofightWalkLeftGo = 1;
                PTwofightWalkRightGo = -1;
            end
        end
    end
    %------------------------General Game Functions------------------------
        
    %moves the player character
    function move
        %moves head
        if headDot(1) + walkSpeed > 0 && headDot(1) + walkSpeed < screenWidth;
            headDot(1) = headDot(1) + walkSpeed;
        end
        headDot(2) = headDot(2) + jumpSpeed;
        %moves jump
        if jumpSpeed ~= 0 || headDot(2) > headDotStartY;
            jumpSpeed = jumpSpeed - jumpMaxSpeed*0.1;
        end
    end

    %clears screen
    function clear
        hold off;
        plot(1,1)
    end

    %man stand position
    function stand
        %resets to initial body position
        topBodyDot = [headDot(1), headDot(2)-5];
        bottomBodyDot = [topBodyDot(1), topBodyDot(2)-20];
        %right elbow
        elbowDotOne = [topBodyDot(1)+3,topBodyDot(2)-10];
        %left elbow
        elbowDotTwo = [topBodyDot(1)-3,topBodyDot(2)-10];
        %right hand
        handDotOne = [topBodyDot(1)+6,bottomBodyDot(2)];
        %left hand
        handDotTwo = [topBodyDot(1)-6,bottomBodyDot(2)];
        %right knee
        kneeDotOne = [bottomBodyDot(1)+3,bottomBodyDot(2)-10];
        %left hand
        kneeDotTwo = [topBodyDot(1)-3,bottomBodyDot(2)-10];
        %right foot
        footDotOne = [bottomBodyDot(1)+6,bottomBodyDot(2)-20];
        %left foot
        footDotTwo = [bottomBodyDot(1)-6,bottomBodyDot(2)-20];
    end
    
    %draws the screen
    function draw
        clear()
        %the flash stuff makes the man flash on/off after he is hit
        if flash == 1 && mod(flashCounter,2) == 0;
            flashCounter = flashCounter - 1;
        elseif flashCounter <= 0;
            flashCounter = 10;
            flash = 0;
        else
            if flash == 1;
                flashCounter = flashCounter - 1;
            end
            %draws head
            circleFunction(headDot(1),headDot(2),headRadius,[0 0 0]);
            hold on;
            %draws torso 
            plot([topBodyDot(1),bottomBodyDot(1)],[topBodyDot(2),bottomBodyDot(2)],'color',[0 0 0]);
            %draws lines from shoulders to elbows
            plot([topBodyDot(1),elbowDotOne(1)],[topBodyDot(2),elbowDotOne(2)],'color',[0 0 0]);
            plot([topBodyDot(1),elbowDotTwo(1)],[topBodyDot(2),elbowDotTwo(2)],'color',[0 0 0]);
            %draws lines from elbows to hands
            plot([elbowDotOne(1),handDotOne(1)],[elbowDotOne(2),handDotOne(2)],'color',[0 0 0]);
            plot([elbowDotTwo(1),handDotTwo(1)],[elbowDotTwo(2),handDotTwo(2)],'color',[0 0 0]);
            %draws lines from hips to knees
            plot([bottomBodyDot(1),kneeDotOne(1)],[bottomBodyDot(2),kneeDotOne(2)],'color',[0 0 0]);
            plot([bottomBodyDot(1),kneeDotTwo(1)],[bottomBodyDot(2),kneeDotTwo(2)],'color',[0 0 0]);
            %draws lines from knees to feet
            plot([kneeDotOne(1),footDotOne(1)],[kneeDotOne(2),footDotOne(2)],'color',[0 0 0]);
            plot([kneeDotTwo(1),footDotTwo(1)],[kneeDotTwo(2),footDotTwo(2)],'color',[0 0 0]); 
        end
        %draws the missles
        if missleGo == 1;
            for missle = 1:length(missleCellArray);
                if isempty(missleCellArray{missle});
                    break
                else
                    matrix = missleCellArray{missle};
                    %cicleFunction(matrix(1),matrix(2),missleRadius);
                    rectangle('Position',[matrix(1)-missleRadius,matrix(2)-missleRadius,missleRadius*2,missleRadius*2],'Curvature',[1,1],'edgecolor',[rand rand rand]);
                end
            end
            %show the score
            text(10,heartYPosition-20,num2str(totalMissleCounter-1));
        end
        %draws health bar
        for heart = 1:HP;
           circleFunction(heartXPosition+(heart-1)*20,heartYPosition,heartRadius,[1 0 0]);
        end
        
        %sets axes size
        if fightGo > 0;
            %drawing player one/two gloves
            circleFunction(handDotOne(1)+1,handDotOne(2)+1,2,[1 0 0]);
            circleFunction(handDotTwo(1)+1,handDotTwo(2)+1,2, [1 0 0]);
            circleFunction(PTwohandDotOne(1)+1,PTwohandDotOne(2)+1,2, [0 0 1]);
            circleFunction(PTwohandDotTwo(1)+1,PTwohandDotTwo(2)+1,2, [0 0 1]);
            %drawing Player Two
            circleFunction(PTwoheadDot(1),PTwoheadDot(2),headRadius,[0 0 0]);
            hold on;
            %draws torso 
            plot([PTwotopBodyDot(1),PTwobottomBodyDot(1)],[PTwotopBodyDot(2),PTwobottomBodyDot(2)],'color',[0 0 0]);
            %draws lines from shoulders to elbows
            plot([PTwotopBodyDot(1),PTwoelbowDotOne(1)],[PTwotopBodyDot(2),PTwoelbowDotOne(2)],'color',[0 0 0]);
            plot([PTwotopBodyDot(1),PTwoelbowDotTwo(1)],[PTwotopBodyDot(2),PTwoelbowDotTwo(2)],'color',[0 0 0]);
            %draws lines from elbows to hands
            plot([PTwoelbowDotOne(1),PTwohandDotOne(1)],[PTwoelbowDotOne(2),PTwohandDotOne(2)],'color',[0 0 0]);
            plot([PTwoelbowDotTwo(1),PTwohandDotTwo(1)],[PTwoelbowDotTwo(2),PTwohandDotTwo(2)],'color',[0 0 0]);
            %draws lines from hips to knees
            plot([PTwobottomBodyDot(1),PTwokneeDotOne(1)],[PTwobottomBodyDot(2),PTwokneeDotOne(2)],'color',[0 0 0]);
            plot([PTwobottomBodyDot(1),PTwokneeDotTwo(1)],[PTwobottomBodyDot(2),PTwokneeDotTwo(2)],'color',[0 0 0]);
            %draws lines from knees to feet
            plot([PTwokneeDotOne(1),PTwofootDotOne(1)],[PTwokneeDotOne(2),PTwofootDotOne(2)],'color',[0 0 0]);
            plot([PTwokneeDotTwo(1),PTwofootDotTwo(1)],[PTwokneeDotTwo(2),PTwofootDotTwo(2)],'color',[0 0 0]); 
            %Player two movemnts
            %player two health bar
            for heart = 1:PTwoHP;
                circleFunction((screenWidth-heartXPosition)-(heart-1)*20,heartYPosition,heartRadius,[0 0 0]);
            end
            if AI > 0;
                text(10,screenHeight-40,'You have AI enabled. Press n to switch to Two player mode'); 
            elseif AI < 0;
                text(10,screenHeight-40,'You have Two Player enabled. Press n to switch to AI mode'); 
            end
        end
        axis([0 screenWidth 0 screenHeight]);        
        pause(pauseTime);
    end

    %enables circle drawing
    function h = circleFunction(x,y,r,color)
        d = r*2;
        px = x-r;
        py = y-r;
        h = rectangle('Position',[px py d d],'Curvature',[1,1],'edgecolor',color);
    end

    function gameLoop
        while Game;
            if fightGo > 0;
                %run the AI
                if AI > 0;
                    AIChoice();
                end
                %if headDot(1)< 0 || headDot(1) > screenWidth;
                    %headDot(1) = screenWidth/2;
                    %PTwoheadDot(1) = screenWidth/2 + 40;
                %end
                fightWalk();
                PTwofightWalk();
                draw();
                if HP > 0 && PTwoHP == 0;
                    Game = 0;
                    close;
                    figure()
                    text(0.4,0.5,'Player One Wins!');
                elseif HP == 0 && PTwoHP > 0;
                    Game = 0;
                    close;
                    figure()
                    if AI >0;
                        text(0.4,0.5,'You Lose!')
                    else
                        text(0.4,0.5,'Player Two Wins!');
                    end
                elseif HP == 0 && PTwoHP == 0;
                    Game = 0;
                    close;
                    figure()
                    text(0.4,0.5,'Double KO!');
                end
            elseif missleGo > 0;
                if walkRightGo > 0;
                    walkRight();
                elseif walkLeftGo > 0;
                    walkLeft();
                elseif jumpGo > 0;
                    jump();
                end
                if missleBreakCounter <= 0;
                    for i=1:randi(5);
                        addMissle();
                    end
                    missleBreakCounter = missleBreakMax;
                end
                moveMissle()
                %head reset
                if (headDot(2) <= headDotStartY && jumpSpeed < 0);
                    headDot(2) = headDotStartY;
                    jumpSpeed = 0;
                    stand();
                    jumpGo = -1;
                end
                %collisions are checked here too, double collision checks are not a
                %problem because the character flashes after a collision
                checkCollision()
                draw()
                %print score
                if Game == 0 && missleGo > 0;
                    delete(GUI);
                    figure();
                    text(0.4,0.5,strcat('Your Score:', num2str(totalMissleCounter - 1)));
                end
            end
        end
    end
end
    
