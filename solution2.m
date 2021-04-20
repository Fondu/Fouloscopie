    if (robot.cible_detected==0)
        SAFE_BORDER = 0.15;
        if INFO.murs.dist_droite < SAFE_BORDER
            robot.endedMove = 1;
        end    
        if INFO.murs.dist_haut < SAFE_BORDER
            robot.endedMove = 1;
        end
        
        if(robot.reckonPosition == 0)
            if((robot.x > (robot.reckonXmin-0.1)) && (robot.x < (robot.reckonXmin+0.1)))
                if((robot.y > (robot.reckonYmin-0.1)) && (robot.y < (robot.reckonYmin+0.1)))
                    robot.reckonPosition = 1;
                end
            end
        end
        if(robot.reckonPosition == 0)
            vx = robot.reckonXmin-robot.x ; 
            vy = robot.reckonYmin-robot.y ;
            robot.move(vx,vy) ;
        else
            if(robot.endedMove == 0)
                if((robot.x > (robot.xMove-0.1)) && (robot.x < (robot.xMove+0.1)))
                    if((robot.y > (robot.yMove-0.05)) && (robot.y < (robot.yMove+0.05)))
                        robot.endedMove = 1;
                    end
                end
            end
            if(robot.endedMove==0)
                robot.move(robot.xMove-robot.x,robot.yMove-robot.y) ;
            else
                if(robot.reckonLoop>=8)
                    robot.move(0-robot.x,0-robot.y) ;
                else
                    robot.xMove = robot.reckonXmin+(mod(robot.reckonLoop, 2) * robot.xLen/4) ; 
                    robot.yMove = robot.reckonYmin+((robot.reckonLoop-1) * robot.yLen/15) ;
                    robot.move(robot.xMove-robot.x,robot.yMove-robot.y) ;
                    robot.reckonLoop = robot.reckonLoop+1 ;
                    robot.endedMove=0;
                end
            end
        end
    else
        if(robot.info_transmitted == 0 && robot.transmition_index < 12)
            robot.move(0-robot.x,0-robot.y) ;
            for i=1:INFO.nbVoisins
                voisin = INFO.voisins{i};
                if(voisin.info_transmitted==0)
                    voisin.set_info_cible(robot.cible_x, robot.cible_y, robot.transmition_index+1);
                    robot.info_transmitted = 1;
                    break;
                end
            end
        else
            if (robot.cible_attacked==0)
                vx = robot.cible_x-robot.x ; 
                vy = robot.cible_y-robot.y ;
                robot.move(vx,vy);
            else
                robot.move(0,0);
            end
        end
    end