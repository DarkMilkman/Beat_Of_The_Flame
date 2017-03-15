package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Ryan Sobczak
	 */

	public class Main extends MovieClip 
	{
		//background
		var background:MovieClip;
		var boardMaxXWidth:int;
		
		//rhythm
		var rhythmWon:Boolean;
		var drumMC:MovieClip;
		var beatMC:MovieClip;
		var beatArray:Array;
		var beatYLocArray:Array;
		var beatSpeedNight:Number;
		var beatSpeed:Number;
		var totalBeatNumber:int;
		var rhythmGame:Boolean;	
		var failed:Boolean;
		
		//player
		var player:MovieClip;
		
		//movement
		var moveMarker:MovieClip;	
		var playerPrevPosX:Number;
		var playerPrevPosY:Number;
		var newX:int;
		var newY:int;		
		var playerSpeed:int;
		var completedMove:Boolean;
		
		//Day/Night cycle
		var isNight:Boolean;
		var TimeOfDayCycle:int;
		var timer:int;
		
		//midCircleLoc
		var midCircleTL:int;
		var midCirlceTR:int;
		var midCircleBL:int;
		var midCircleBR:int;
		
		//Wood varibles
		var totalWoodsNumber:int;
		var woodIndex:int;
		var woodArray:Array;
		var wood:MovieClip;
		var woodXLocation:Array;
		var woodYLocation:Array;
		
		//rollOver Varibles
		var rollOverWood:Boolean;
		
		//fire
		var fire:MovieClip;
		
		var fireBarFire:MovieClip;
		var fireBar:MovieClip;
		var fireDecriment:Number;
		var fireGain:Number;
		
		//menu
		var GameStateNum:int = 0; 
		var mainMenu:MovieClip;
		var helpMenu:MovieClip;
		var backButton:MovieClip;
		var helpButton:MovieClip;
		var playButton:MovieClip;
		
		//sound
		var music:Sound;
		var drumSound:Sound;
		var soundTrans:SoundTransform; 
		var soundChannel:SoundChannel;
		
		//cutscene
		var cutSceneNum:int = 0;
		var cutSceneMC:MovieClip;
		var nextButton:MovieClip;
		
		//wendigo
		var wendigo:MovieClip;
		var wendiStartX:int;
		var wendiStartY:int;
		var wendiScared:Boolean;
		var wendiSpeed:Number;
		
		//movement time
		var time:Number;
		var playerTime:Number;
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function Main() 
		{
			initMusic();
			init();
		}

		private function init():void 
		{
			//init Main Menu
			if (GameStateNum == 0)
			{
				initMainMenu();
				initMenuEvents();
			}
			else if(GameStateNum == 1)
				initHelpMenu();
				
			else if (GameStateNum == 2)	
			{
				initGame();
				initCutScene();
				initCutSceneEvents();
			}
			else if (GameStateNum == 3)
				initActualGame();
		}
		
		private function initMusic():void 
		{
			soundTrans = new SoundTransform();
			soundChannel = new SoundChannel();
			
			soundTrans.volume = 0.2;
			
			music = new Music();
			drumSound = new DrumSound();
			
			soundChannel = music.play(0, 999);
			soundChannel.soundTransform = soundTrans; 
			
		}
		
		private function initGame():void 
		{
				//init Var
				initNumbers();
				initBooleanVars();
				
				//init MovieClips
				initBackground();
				initPlayer();
				initFire();
				//initFireBar();
				//initDrum();
				
				//init Events
				//initEvents();
				ArrowKeyInput.Init(stage);
		}
		
				
		private function initActualGame():void 
		{
			//init Var
			initNumbers();
			initBooleanVars();
			
			//init MovieClips
			initBackground();
			initWoodPiles();
			initWendigo();
			initFire();
			initPlayer();
			initFireBar();
			//initDrum();
			
			//init Events
			initEvents();
		}
		
		private function initMenuEvents():void 
		{
			addEventListener(Event.ENTER_FRAME, menuUpdate);
		}
		
		private function menuUpdate(e:Event):void 
		{
			if (GameStateNum == 0)
			{
				rollOverMainMenu();
				stage.addEventListener(MouseEvent.CLICK, changeGameState);
			}
			else
			{
				rollOverHelpMenu();
				stage.addEventListener(MouseEvent.CLICK, changeBackToMainMenu);
			}
		}
		
		private function rollOverHelpMenu():void 
		{
			if ((mouseX > backButton.x) && (mouseX < backButton.x + backButton. width) 
			&& (mouseY > backButton.y) && (mouseY < backButton.y + backButton. height))
			{
				backButton.alpha = 0.5;			
			}
			
			else 
			{
				backButton.alpha = 1;
			}
		}
		
		private function initHelpMenu():void 
		{
			if (!helpMenu)
				helpMenu = new HelpMenu()
				
			addChild(helpMenu);
			helpMenu.x = 2;
			helpMenu.y = 0;
			
			if (!backButton)
				backButton = new BackButton();
				
			addChild(backButton);
			backButton.x = 750;
			backButton.y = 20 + playButton.y + playButton.height;
		}
		
		private function changeBackToMainMenu(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.CLICK, changeBackToMainMenu);
			
			if ((mouseX > backButton.x) && (mouseX < backButton.x + backButton. width) 
			&& (mouseY > backButton.y) && (mouseY < backButton.y + backButton. height))
			{
				GameStateNum = 0;
			}
			
			init();
		}
		
		private function initMainMenu():void 
		{
			if (!mainMenu)
				mainMenu = new MainMenu();
				
			addChild(mainMenu);
			mainMenu.x = 0;
			mainMenu.y = 0;
			
			if (!playButton)
				playButton = new PlayButton();
				
			addChild(playButton);
			playButton.x = 750;
			playButton.y = 390;
			
			if (!helpButton)
				helpButton = new HelpButton();
				
			addChild(helpButton);
			helpButton.x = 750;
			helpButton.y = 20 + playButton.y + playButton.height;
			
			rollOverMainMenu();
		}
		
		private function rollOverMainMenu():void 
		{		
			if ((mouseX > playButton.x) && (mouseX < playButton.x + playButton. width) 
			&& (mouseY > playButton.y) && (mouseY < playButton.y + playButton. height))
			{
				playButton.alpha = 0.5;			
				helpButton.alpha = 1;
			}
			
			else if ((mouseX > helpButton.x) && (mouseX < helpButton.x + helpButton. width) 
			&& (mouseY > helpButton.y) && (mouseY < helpButton.y + helpButton. height))
			{
				playButton.alpha = 1;
				helpButton.alpha = 0.5;
			}
			
			else 
			{
				playButton.alpha = 1;
				helpButton.alpha = 1;
			}
		}
		
		private function changeGameState(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.CLICK, changeGameState);
			
			//var myColorTransform = new ColorTransform();
			//myColorTransform.color = 0x770E12;
			//playButton.transform.colorTransform = myColorTransform;

			if ((mouseX > playButton.x) && (mouseX < playButton.x + playButton. width) 
			&& (mouseY > playButton.y) && (mouseY < playButton.y + playButton. height))
			{
				//playButton.transform.colorTransform = myColorTransform;
				GameStateNum = 2;
			}
			
			else if ((mouseX > helpButton.x) && (mouseX < helpButton.x + helpButton. width) 
			&& (mouseY > helpButton.y) && (mouseY < helpButton.y + helpButton. height))
			{
				//helpButton.transform.colorTransform = myColorTransform;
				GameStateNum = 1;
			}
			
			init();
		}
///////////////////////////////////////////////////////////////////////////////////////////////////////
				
		private function initCutSceneEvents():void 
		{
			removeEventListener(Event.ENTER_FRAME, menuUpdate);
			addEventListener(Event.ENTER_FRAME, cutSceneUpdate);
		}
		
		private function cutSceneUpdate(e:Event):void 
		{
			if(cutSceneNum != 5)
				rollOverNextButton();
				
			if (cutSceneNum == 5)
			{
				if(!rhythmGame)
				 startRhythmIntro();
				 
				controlsIntro();
				moveBeatsIntro();	

			}
		}
		
		private function controlsIntro():void 
		{
			if (ArrowKeyInput.space)
			{
				for (var i:int = 0; i < beatArray.length; i++) 
				{					
					if ((beatYLocArray[i] >= 512 - beatMC.height) && (beatYLocArray[i] <= 610))
					{
						soundChannel = drumSound.play();
						
						removeChild(beatArray[i]);
						beatArray.splice(i, 1);
						beatYLocArray.splice(i, 1);
					}
				}
			}
		}
		
		private function moveBeatsIntro():void 
		{
			if (beatArray.length != 0)
			{
				for (var i:int = 0; i < beatArray.length; i++) 
				{
					beatYLocArray[i] += beatSpeed;
					beatArray[i].y = beatYLocArray[i];
					if (beatYLocArray[i] > 600)
						resetIntro();
				}
			}

			if (beatArray.length == 0)
			{
				resetIntro();
			}
		}
		
		private function resetIntro():void 
		{
			if(beatArray.length != 0)
			{
				for (var i:int = 0; i < beatArray.length; i++) 
					removeChild(beatArray[i]);

				rhythmGame = false;
				failed = true;
				
				cutSceneNum = 6;
				initCutScene();
			}
			else
			{
				rhythmGame = false;				
				cutSceneNum = 7;
				failed = false;
				initCutScene();
			}
		}
		
		private function startRhythmIntro():void 
		{		
			rhythmGame = true;
			
			initBeat();
		}
		
		private function rollOverNextButton():void 
		{			
			if ((mouseX > wood.x) && (mouseX < wood.x + wood.width) 
			&& (mouseY > wood.y) && (mouseY < wood.y + wood.height))
			{
				wood.alpha = 0.7;	
				stage.addEventListener(MouseEvent.CLICK, changeSceneNum);
			}
			else
			{
				wood.alpha = 1;	
			}
			
			if ((mouseX > nextButton.x) && (mouseX < nextButton.x + nextButton. width) 
			&& (mouseY > nextButton.y) && (mouseY < nextButton.y + nextButton. height))
			{
				nextButton.alpha = 0.5;	
				stage.addEventListener(MouseEvent.CLICK, changeSceneNum);
			}
			else
			{
				nextButton.alpha = 1;	
			}
		}
		
		private function changeSceneNum(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.CLICK, changeSceneNum);
			
			if ((mouseX > nextButton.x) && (mouseX < nextButton.x + nextButton. width) 
			&& (mouseY > nextButton.y) && (mouseY < nextButton.y + nextButton. height))
			{				
				if (cutSceneNum == 8)
				{
					removeChild(cutSceneMC);
					removeChild(nextButton);
					GameStateNum = 3;
					init();
				}
				
				else if (cutSceneNum == 6)
				{
					cutSceneNum = 4;
					initCutScene();
				}
				
				else if ((cutSceneNum != 3) && (cutSceneNum != 5))
				{
					cutSceneNum++;
					initCutScene();
				}
			}
			
			else if ((mouseX > wood.x) && (mouseX < wood.x + wood.width) 
			&& (mouseY > wood.y) && (mouseY < wood.y + wood.height) && (cutSceneNum == 3))
			{
				cutSceneNum++;
				initCutScene();
			}		
		}
		
		private function initCutScene():void 
		{
			if (cutSceneNum == 0)
			{
				initWoodCutScene();
				cutSceneMC = new Scene1();
				addChild(cutSceneMC);
			}
			else if (cutSceneNum == 1)
			{
				removeChild(cutSceneMC);
				cutSceneMC = new Scene2();
				addChild(cutSceneMC);
				removeChild(nextButton);
			}
			else if (cutSceneNum == 2)
			{
				removeChild(cutSceneMC);
				cutSceneMC = new Scene3();
				addChild(cutSceneMC);
				removeChild(nextButton);
			}
			else if (cutSceneNum == 3)
			{
				//wood
				removeChild(cutSceneMC);
				cutSceneMC = new Scene4();
				addChild(cutSceneMC);
				removeChild(nextButton);
			}
			else if (cutSceneNum == 4)
			{
				removeChild(cutSceneMC);
				cutSceneMC = new Scene5();
				addChild(cutSceneMC);
				//removeChild(nextButton);
			}
			else if (cutSceneNum == 5)
			{
				//rhythm
				removeChild(cutSceneMC);
				cutSceneMC = new Scene6();
				addChild(cutSceneMC);
				//removeChild(nextButton);
			}			
			
			if (cutSceneNum == 6)
			{
				trace("fail");
				//fail
				removeChild(cutSceneMC);
				cutSceneMC = new Scene7();
				addChild(cutSceneMC);
				//removeChild(nextButton);
			}
				
			if (cutSceneNum == 7)
			{
				//pass
				removeChild(wood);
				removeChild(cutSceneMC);
				cutSceneMC = new Scene8();
				addChild(cutSceneMC);
				//removeChild(nextButton);
			}
				
			else if (cutSceneNum == 8)
			{
				//end
				removeChild(cutSceneMC);
				cutSceneMC = new Scene9();
				addChild(cutSceneMC);
				removeChild(nextButton);
			}
			
			//trace(cutSceneNum);
			
			if ((cutSceneNum != 3) && (cutSceneNum != 5))
			{
				if(!nextButton)
					nextButton = new NextButton();
				addChild(nextButton);
				nextButton.scaleX = 0.7;
				nextButton.scaleY = 0.7;
				nextButton.x = 570;
				nextButton.y = 250;
			}
		}
		
		private function initWoodCutScene():void 
		{
			wood = new Wood();
			addChild(wood);
			wood.x = 500;
			wood.y = 600;
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
		private function initWendigo():void 
		{
			if (!wendigo) 
				wendigo = new Wendigo();
			addChild(wendigo);
			
			wendiStartX = randi(-250, -50 - wendigo.width, 1);
			wendiStartY = randi(0, stage.stageHeight, 1);
			
			wendigo.x = wendiStartX;
			wendigo.y = wendiStartY;
			wendigo.scaleX = 0.3;
			wendigo.scaleY = 0.3;
		}
		
		private function initFire():void 
		{
			fire = new Fire();
			addChild(fire);
			fire.x = stage.stageWidth / 2 - 230;
			fire.y = stage.stageHeight / 2 - 90;
		}
		
				
		private function initFireBar():void 
		{
			fireBar = new FireBar();
			addChild(fireBar);
			fireBar.scaleY = 0.7;
			fireBar.scaleX = 0.7;		
			fireBar.x = 150;
			fireBar.y = stage.stageHeight - 20;
			
			fireBarFire = new FullFire();
			addChild(fireBarFire);
			fireBarFire.scaleY = 0.7;
			fireBarFire.scaleX = 0.7;
			fireBarFire.x = 94 + fireBar.width;
			fireBarFire.y = stage.stageHeight - 115;
		}
		
		private function initWoodPiles():void 
		{
			woodArray = new Array;
			woodXLocation = new Array;
			woodYLocation = new Array;
			
			var maxLocX:int;
			var maxLocY:int;
			var minLocX:int = 0;
			var minLocY:int = 50;
			var numberInRani:int = 20;
			
			for (var i:int = 0; i < totalBeatNumber; i++) 
			{
				wood = new Wood();
				woodArray.push(wood);

				maxLocX = boardMaxXWidth - wood.width;
			    maxLocY = stage.stageHeight - wood.height;
				
				woodXLocation.push(randi(minLocX, maxLocX, numberInRani));
				woodYLocation.push(randi(minLocY, maxLocY, numberInRani));
				checkValidLoc(i);
				
				addChild(woodArray[i]);
				woodArray[i].x = woodXLocation[i];
				woodArray[i].y = woodYLocation[i];
			}
		}
		
		private function checkValidLoc(index:int):void 
		{
			var randiNum:int;
			
			//x = 228 - width, 500
			//y = 340 - height, 508
			if ((woodXLocation[index] + woodArray[index].width >= midCircleTL) && (woodXLocation[index] <= midCirlceTR)
				&& (woodYLocation[index] + woodArray[index].height >= midCircleBL) && (woodYLocation[index] <= midCircleBR))
				{
					randiNum = randi(0, 2, 0);
					
					if (randiNum % 2 == 0)
						woodXLocation[index] = 520;
					else
						woodXLocation[index] = 200 - woodArray[index].width;
					
					randiNum = randi(0, 2, 0);
					if (randiNum % 2 == 0)
						woodYLocation[index] = 550;
					else
						woodYLocation[index] = 250;
				}
		}
		
		private function addWoodToStage():void 
		{
			for (var i:int = 0; i < totalBeatNumber; i++) 
			{				
				addChild(woodArray[i]);
				woodArray[i].x = woodXLocation[i];
				woodArray[i].y = woodYLocation[i];
			}
		}
		
		private function initBackground():void 
		{
			if (!isNight)
			{
				background = new Background();
				addChild(background);
			}
			else 
			{
				background = new Background2();
				addChild(background);
			}
			
			background.x = 0;
			background.y = 0;
		}
		
		private function initNumbers():void 
		{
			time = 0;
			playerTime = 0;
			
			wendiSpeed = 500;
			wendiScared = false;
			
			midCircleTL = 228;
			midCirlceTR = 500;
			midCircleBL = 340;
			midCircleBR = 508;
		
			boardMaxXWidth = 700;
			
			totalWoodsNumber = 5;
			totalWoodsNumber = 0;
			totalBeatNumber = 5;
			
			TimeOfDayCycle = 2700;
			playerSpeed = 100;
			timer = 0;
			
			beatSpeedNight = 8;
			beatSpeed = 5;
			fireDecriment = 0.2;
			fireGain = 75;
		}

		private function initPlayer():void 
		{
			if (!player)
				player = new Player();

			addChild(player);
			player.x = stage.stageWidth / 2 - 220;
			player.y = stage.stageHeight / 2 - 320;
			trace(player.x, player.y);
		}

		private function initBooleanVars():void 
		{
			rollOverWood = true;
			rhythmWon = false;
			completedMove = false;
			rhythmGame = false;
			failed = false;
			isNight = false;
		}

		private function initBeat():void 
		{
			beatArray = new Array;
			beatYLocArray = new Array;
			var numberInRandi:int = 100;
			var minNum:Number = -100;
			var maxNum:Number = 0;

			for (var i:int = 0; i < totalBeatNumber; i++) 
			{
				beatMC = new Beat();
				beatArray.push(beatMC);

				if (i == 4)
					beatYLocArray.push(randi(maxNum, maxNum, numberInRandi));
				else
					beatYLocArray.push(randi(minNum, maxNum, numberInRandi));

				addChild(beatMC);
				beatMC.x = 810;
				beatMC.y = beatYLocArray[i];

				maxNum = minNum;
				minNum += minNum;
			}
		}

		private function randi(minNum:int, maxNum:int, number:int):int
		{
			return (Math.floor(Math.random() * (maxNum - minNum - number)) + minNum);
		}

		private function initEvents():void 
		{
			removeEventListener(Event.ENTER_FRAME, cutSceneUpdate);
			
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function startRhythm(e:MouseEvent):void 
		{
			trace("start Rhythm");
			rhythmGame = true;
			
			initBeat();
			initMoveMarker();
			
			if(rollOverWood)
				woodArray[woodIndex].removeEventListener(MouseEvent.CLICK, startRhythm);
			else
				wendigo.removeEventListener(MouseEvent.CLICK, startRhythm);
		}

		private function initMoveMarker():void 
		{
			if (!moveMarker)
				moveMarker = new LocMarker();

			moveMarker.x = mouseX - moveMarker.width / 2;
			moveMarker.y = mouseY - moveMarker.height / 2;
		}

		private function update(e:Event):void 
		{
			if (isNight) 
			{
				if ((time <= 1) && (!rhythmGame))
					time += 0.001;
					
				wendigo.x = wendiStartX + time*((fire.x - wendigo.width / 2) - wendiStartX);
				wendigo.y = wendiStartY + time*((fire.y - wendigo.height / 2) - wendiStartY);
				
				if (wendiScared)
				{
					wendiScared = false;
					initWendigo();
				}
			}
			
			timerUpdate();
			fireUpdate();
			
			if ((!rhythmGame))
			{
				if ((player.x <= newX - 5) || (player.x >= newX + 5)
					&& (player.y <= newY - 5) || (player.y >= newY + 5)
					&&(rhythmWon))
				{
					playerTime += 0.01;
					
					player.x = playerPrevPosX + playerTime*(newX - playerPrevPosX);
					player.y = playerPrevPosY + playerTime*(newY - playerPrevPosY);
					
					completedMove = true;
				}
				else
				{
					if (completedMove)
					{
						playerTime = 0;
						removeWoodPile();
					}

					rollOverWoodPiles();
					rollOverWendi();
				}
			}
			else if (rhythmGame)
			{
				moveBeats();
				controls();
			}
		}
		
		private function rollOverWendi():void 
		{
			if ((mouseX > wendigo.x) && (mouseX < wendigo.x + wendigo.width) 
			&& (mouseY > wendigo.y) && (mouseY < wendigo.y + wendigo.height))
			{
				wendigo.alpha = 0.7;
				rollOverWood = false;
				wendigo.addEventListener(MouseEvent.CLICK, startRhythm);
			}
			else
			{
				wendigo.alpha = 1;
			}
		}

		private function fireUpdate():void 
		{
			if ((wendigo.x != fire.x) && (wendigo.y != fire.y))
			{
				fireBar.fireMeter.width -= fireDecriment;
				fireBar.fireMeter.x += 1.1 * fireDecriment;
			}
			else
			{
				fireBar.fireMeter.width = fireBar.fireMeter.width - 1.5 * fireDecriment;
				fireBar.fireMeter.x += 1.51 * fireDecriment;
			}
			
			if (fireBar.fireMeter.width > 340)
			{
				removeChild(fireBarFire);
				fireBarFire = new FullFire();
				addChild(fireBarFire);
				fireBarFire.scaleY = 0.7;
				fireBarFire.scaleX = 0.7;
				fireBarFire.x = 94 + fireBar.width;
				fireBarFire.y = stage.stageHeight - 115;
			}
			else if((fireBar.fireMeter.width <= 340) && (fireBar.fireMeter.width >= 95))
			{
				removeChild(fireBarFire);
				fireBarFire = new MedFire();
				addChild(fireBarFire);
				fireBarFire.scaleY = 0.7;
				fireBarFire.scaleX = 0.7;
				fireBarFire.x = 94 + fireBar.width;
				fireBarFire.y = stage.stageHeight - 110;
			}
			else if((fireBar.fireMeter.width < 95))
			{
				removeChild(fireBarFire);
				fireBarFire = new NoFire();
				addChild(fireBarFire);
				fireBarFire.scaleY = 0.7;
				fireBarFire.scaleX = 0.7;
				fireBarFire.x = 94 + fireBar.width;
				fireBarFire.y = stage.stageHeight - 103;
			}
			
			if (fireBar.fireMeter.width <= 0)
			{
				loseGame();
			}
		}
		
		private function removeWoodPile():void 
		{			
			completedMove = false;
			
			if (rollOverWood)
			{
				increaseFireBar();
				removeChild(woodArray[woodIndex]);
				woodArray.splice(woodIndex, 1);
				woodXLocation.splice(woodIndex, 1);
				woodYLocation.splice(woodIndex, 1);
			}
			else
			{
				trace("Wendi Init");
				time = 0;
				initWendigo();
			}
			
			if (woodArray.length == 1)
			{
				initWoodPiles();
				addPlayerToStage();
			}
		}
		
		private function increaseFireBar():void 
		{
			if (fireBar.fireMeter.width + fireGain > 460)
			{
				fireBar.fireMeter.width = 460;
				fireBar.fireMeter.x = fireBar.x - 125;
			}
			else
			{
				fireBar.fireMeter.width += fireGain;
				fireBar.fireMeter.x -= fireGain;
			}
		}
		
		private function rollOverWoodPiles():void 
		{
			for (var i:int = 0; i < woodArray.length; i++) 
			{
				if ((mouseX > woodXLocation[i]) && (mouseX < woodXLocation[i] + woodArray[i].width) 
				&& (mouseY > woodYLocation[i]) && (mouseY < woodYLocation[i] + woodArray[i].height))
				{
					woodArray[i].alpha = 0.7;
					woodIndex = i;
					rollOverWood = true;
					woodArray[i].addEventListener(MouseEvent.CLICK, startRhythm);
				}
				else
				{
					woodArray[i].alpha = 1;
				}
			}
		}
		
		private function timerUpdate():void 
		{			
			timer++;
			if ((timer >= TimeOfDayCycle) && (isNight) && (!rhythmGame))
			{
				isNight = false;
				
				initBackground();
				addPlayerToStage();
				endGame();
				//timer = 0;
			}
			else if ((timer >= TimeOfDayCycle) && (!rhythmGame))
			{
				isNight = true;
				
				initBackground();
				addPlayerToStage();
				//midGameCutScene();
				timer = 0;
			}	
		}
		
		private function addPlayerToStage():void 
		{
			addChild(fire);

			for (var i:int = 0; i < woodArray.length; i++) 
			{
				addChild(woodArray[i]);
			}
			addChild(wendigo);
			addChild(player);
			
			addChild(fireBar);
			addChild(fireBarFire);
		}

		private function controls():void 
		{
			if (ArrowKeyInput.space)
			{
				for (var i:int = 0; i < beatArray.length; i++) 
				{					
					if ((beatYLocArray[i] >= 512 - beatMC.height) && (beatYLocArray[i] <= 610))
					{
						soundChannel = drumSound.play();
						
						removeChild(beatArray[i]);
						beatArray.splice(i, 1);
						beatYLocArray.splice(i, 1);
					}
				}
			}
		}

		private function reset():void 
		{
			for (var i:int = 0; i < beatArray.length; i++) 
				removeChild(beatArray[i]);

			beatArray.splice(0);
			beatYLocArray.splice(0);

			rhythmGame = false;
			failed = true;
		}

		private function moveBeats():void 
		{
			if (beatArray.length != 0)
			{
				for (var i:int = 0; i < beatArray.length; i++) 
				{
					if(!isNight)
						beatYLocArray[i] += beatSpeed;
					else 
						beatYLocArray[i] += beatSpeedNight;
						
					beatArray[i].y = beatYLocArray[i];
					if (beatYLocArray[i] > 600)
						reset();
				}
			}

			if (beatArray.length == 0)
			{
				movePlayer();
				rhythmGame = false;
			}
		}

		private function movePlayer():void 
		{
			if (!failed)
			{	
				rhythmWon = true;
				playerPrevPosX = player.x;
				playerPrevPosY = player.y;
				newX = moveMarker.x - player.width / 2;
				newY = moveMarker.y - player.height / 2;
			}

			failed = false;
		}

		private function initDrum():void 
		{
			drumMC = new Drum();
			//addChild(drumMC);
			drumMC.x = 810;
			drumMC.y = 512;
		}
////////////////////////////////////////////////////////////////////////////////////////////////////////
		/*private function midGameCutScene():void 
		{
			removeEventListener(Event.ENTER_FRAME, update);
			addEventListener(Event.ENTER_FRAME, midCutSceneMenuUpdate);
		}
		
		private function midCutSceneInit(number:Number):void 
		{
			if (number == 8)
			{
				cutSceneMC = new Scene11();
				addChild(cutSceneMC);
			}
			else if (number == 9)
			{
				removeChild(nextButton);
				removeChild(cutSceneMC);
				cutSceneMC = new Scene12();
				addChild(cutSceneMC);
			}
			
			if(!nextButton)
					nextButton = new NextButton();
			addChild(nextButton);
			nextButton.scaleX = 0.7;
			nextButton.scaleY = 0.7;
			nextButton.x = 570;
			nextButton.y = 250;
			
			
		}
		
		private function midCutSceneMenuUpdate(e:Event):void 
		{		
			midCutSceneInit(cutSceneNum);
			
			if ((mouseX > nextButton.x) && (mouseX < nextButton.x + nextButton. width) 
			&& (mouseY > nextButton.y) && (mouseY < nextButton.y + nextButton. height))
			{			
				nextButton.alpha = 0.5;
				nextButton.addEventListener(MouseEvent.CLICK, changeMidGameSceneNum);
			}
			else
			{
				nextButton.alpha = 1.0;
			}
		}
		
		private function changeMidGameSceneNum(e:MouseEvent):void 
		{
			nextButton.removeEventListener(MouseEvent.CLICK, changeMidGameSceneNum);
			
			cutSceneNum++;
			
			if (cutSceneNum == 10)
			{
				removeChild(nextButton);
				removeChild(cutSceneMC);
				
				removeEventListener(Event.ENTER_FRAME, midCutSceneMenuUpdate);
				addEventListener(Event.ENTER_FRAME, update);
			}
			else
			{
				midCutSceneInit(cutSceneNum);
			}
		}*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////		
		private function endGame():void 
		{
			removeEventListener(Event.ENTER_FRAME, update);
			
			cutSceneMC = new Scene14();
			addChild(cutSceneMC);
			
			if(!nextButton)
					nextButton = new NextButton();
				addChild(nextButton);
				nextButton.scaleX = 0.7;
				nextButton.scaleY = 0.7;
				nextButton.x = 570;
				nextButton.y = 250;
			
			addEventListener(Event.ENTER_FRAME, updateEndScreen);
		}
		
		private function updateEndScreen(e:Event):void 
		{
			if ((mouseX > nextButton.x) && (mouseX < nextButton.x + nextButton. width) 
			&& (mouseY > nextButton.y) && (mouseY < nextButton.y + nextButton. height))
			{			
				nextButton.alpha = 0.5;
				nextButton.addEventListener(MouseEvent.CLICK, endOfGame);
			}
			else
			{
				nextButton.alpha = 1.0;
			}
		}
		
		private function endOfGame(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, updateEndScreen);
			nextButton.removeEventListener(MouseEvent.CLICK, endOfGame);
			GameStateNum = 0;
			cutSceneNum = 0;
			init();
		}
		
		private function loseGame():void 
		{
			removeEventListener(Event.ENTER_FRAME, update);
			
			cutSceneMC = new Scene13();
			addChild(cutSceneMC);
			
			if(!nextButton)
					nextButton = new NextButton();
				addChild(nextButton);
				nextButton.scaleX = 0.7;
				nextButton.scaleY = 0.7;
				nextButton.x = 570;
				nextButton.y = 250;
				
			addEventListener(Event.ENTER_FRAME, updateEndScreen);
		}
	}
}
