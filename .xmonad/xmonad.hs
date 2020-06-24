-- Taken from https://github.com/alemedeiros/dotfiles/tree/master/.xmonad
-- On 2020-06-15

-- See default keybindings here:
-- https://github.com/xmonad/xmonad/blob/2e6312776bd277c775c32e35f9c763d3858e32a4/src/XMonad/Config.hs#L184
-- Diagram:
-- https://wiki.haskell.org/File:Xmbindings.png

-- Add full screen toggle?
-- https://superuser.com/questions/238190/how-can-i-set-my-caps-lock-key-to-toggle-fullscreen-mode-in-xmonad/238454

-- https://advancedweb.hu/lessons-learned-from-using-xmonad-for-a-year/

-- Actions:
--   * multi-head
--     - XMonad.Actions.DynamicWorkspaceGroups
--     - XMonad.Actions.LinkWorkspaces
--     - XMonad.Actions.Submap
--     - XMonad.Actions.Workscreen
--   * revisit
--     - XMonad.Actions.TopicSpace
--     - XMonad.Actions.WorkspaceNames
-- Layouts:
--   * features
--     - XMonad.Layout.IfMax: run different layouts depending on how many windows are
--     - XMonad.Layout.MagicFocus: automatically make focused window master
--     - XMonad.Layout.Magnifier: increase size of focused window
--     - XMonad.Layout.PerScreen: run different layouts depending on screen width
--     - XMonad.Layout.PerWorkspace: per-workspace layout options / modifiers
--     - XMonad.Layout.WindowNavigation: easy window navigation (may be worth to use  in hjkl instead of its defaults -- defaults could become ctrl + command)
--   * multi-head
--     - XMonad.Layout.IndependentScreens: "virtual workspaces" per screen
-- Hooks:
--   * multi-head
--     - XMonad.Hooks.DynamicBars
--   * features
--     - XMonad.Hooks.Place: floating windows placement
-- Utils:
--   * features
--     - XMonad.Util.NamedScratchpad: notes / misc scratchpads
--   * layout helpers
--     - XMonad.Util.NamedWindows: XMonad.Layout.Tabbed
module Main (main) where

import qualified Codec.Binary.UTF8.String as UTF8
import Control.Monad
import qualified Data.Map as M
import Graphics.X11.ExtraTypes
import System.IO

import XMonad
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import qualified XMonad.Actions.FlexibleResize as FR
import XMonad.Actions.GridSelect
import XMonad.Actions.GroupNavigation
import XMonad.Actions.SwapWorkspaces
import XMonad.Actions.ShowText
import XMonad.Config.Kde
import XMonad.Layout.Dishes
import XMonad.Layout.Drawer
import XMonad.Layout.Fullscreen as FS
import XMonad.Layout.Hidden
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.WallpaperSetter
import XMonad.Util.Run
import XMonad.Util.Ungrab
import XMonad.Util.WorkspaceCompare
import XMonad.Util.SpawnOnce


main :: IO ()
main = xmonad $ ewmh myConfig

mySTConfig = def { st_font = "xft:Fira Code:size=28:antialias=true"
                         , st_bg   = "black"
                         , st_fg   = "green"
                         }

-- **Config**
myConfig = kde4Config
    -- Behavior
    { modMask            = mod4Mask -- Super as ModKey
    -- , terminal           = "xfce4-terminal"
    , focusFollowsMouse  = False
    , clickJustFocuses   = False

    -- Appearance
    , borderWidth        = 2
    , focusedBorderColor = myFocusedBorderColor
    , normalBorderColor  = myUnfocusedBorderColor

    -- Hooks
    , layoutHook         = myLayoutHooks myLayouts
    , startupHook        = startupHook kde4Config >> myStartupHook
    , manageHook         = myManageHook      <+> manageHook kde4Config
    , logHook            = polybarLogHook    <+> logHook kde4Config
    , handleEventHook    = myHandleEventHook <+> handleEventHook kde4Config <+> handleTimerEvent

    -- Bindings
    , keys               = myKeys            <+> keys kde4Config
    , mouseBindings      = myMouse           <+> mouseBindings kde4Config
    }

-- **Bindings**
myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList $
    -- *Programs*
    [ ((modm,                 xK_Escape),    unGrab >> safeSpawn "loginctl" ["lock-session"])
    , ((modm .|. shiftMask,   xK_w),         safeSpawn "rofi" ["-show-icons", "-show", "window", "-font", "Iosevka Aile 18"] )
    , ((modm,                 xK_d),         safeSpawn "rofi" ["-show-icons", "-modi", "drun", "-show", "drun", "-font", "Iosevka Aile 18"] )
    , ((modm,                 xK_p),         safeSpawn "rofi" ["-show-icons", "-modi", "drun", "-show", "drun"] )
    , ((modm .|. controlMask, xK_p),         safeSpawnProg "bwmenu")

    -- shift-win-q: Kill window
    , ((modm .|. shiftMask,   xK_q),         kill)
    -- control-shift-win-q: Quit DE (KDE)
    , ((modm .|. shiftMask .|. controlMask,   xK_q),         safeSpawn "qdbus" ["org.kde.ksmserver", "/KSMServer", "logout", "1", "3", "3"])
    -- control-shift-win-w: Quit DE (Non-KDE)
    -- Don't know how to do this!
    -- mod q: Reload settings
    , ((modm              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad

    -- *Overrides*
    -- Swap Enter and Shift Enter
    , ((modm,               xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window

    -- *Overrides*
    -- Prev: (modm, xK_c)
    -- Reason: CycleWS - (move|shift)To Next EmptyWS
    , ((modm .|. controlMask, xK_c),         kill)

    -- *CycleWS*
    -- Left-Right - Workspaces
    -- Up-Down - Screens

    -- Example of flashing WS name:
    -- nextWS >> logCurrent >>= flashText mySTConfig 1 . fromMaybe ""
    , ((modm,                 xK_Right),     nextWS)
    , ((modm,                 xK_Left),      prevWS)
    , ((modm .|. shiftMask,   xK_Right),     shiftToNext >> nextWS)
    , ((modm .|. shiftMask,   xK_Left),      shiftToPrev >> prevWS)
    , ((modm,                 xK_Up),        nextScreen)
    , ((modm,                 xK_Down),      prevScreen)
    , ((modm .|. shiftMask,   xK_Up),        shiftNextScreen >> nextScreen)
    , ((modm .|. shiftMask,   xK_Down),      shiftPrevScreen >> prevScreen)
    , ((modm,                 xK_z),         toggleWS)
    , ((modm,                 xK_c),         moveTo Next EmptyWS)
    , ((modm .|. shiftMask,   xK_c),         shiftTo Next EmptyWS)

    -- *GridSelect*
    , ((modm,                 xK_g),         goToSelected def)

    -- *GroupNavigation*
    -- Same className navigation
    , ((modm,                 xK_f),         nextMatchWithThis Forward  className)
    , ((modm,                 xK_b),         nextMatchWithThis Backward className)

    , ((modm .|. shiftMask,   xK_b),         sendMessage ToggleStruts)

    -- *SwapWorkspaces*
    -- Swap workspaces contents to (Next|Prev) workspace
    , ((modm .|. controlMask, xK_Right),     swapTo Next)
    , ((modm .|. controlMask, xK_Left),      swapTo Prev)

    -- *UrgencyHook*
    -- Focus or clear Urgency tag
    , ((modm,                 xK_Tab),       focusUrgent)
    , ((modm .|. controlMask, xK_z),         clearUrgents)

    -- *Hidden*
    -- Minimize
    -- TODO: make unminimization add window below
    , ((modm,                 xK_n),         withFocused hideWindow)
    , ((modm .|. shiftMask,   xK_n),         popNewestHiddenWindow)
    -- TODO: Unminimize all
    -- , ((modm .|. controlMask, xK_n), {- TODO -})

    -- Media keys
    -- See program "pavucontrol" for a pulse audio control panel

    -- Turning these off while I go back to kde
    -- XF86AudioMute
    -- , ((0, 0x1008ff12), flashText mySTConfig 1 "Toggle mute" >> safeSpawn "pactl" ["set-sink-mute",     "@DEFAULT_SINK@",   "toggle"])
    -- -- XF86AudioRaiseVolume
    -- , ((0, 0x1008ff13), flashText mySTConfig 1 "Vol up" >> safeSpawn "pactl" ["set-sink-volume",   "@DEFAULT_SINK@",   "+5%"])
    -- -- XF86AudioLowerVolume
    -- , ((0, 0x1008ff11), safeSpawn "pactl" ["set-sink-volume",   "@DEFAULT_SINK@",   "-5%"] >> flashText mySTConfig 10 "Vol down")

    -- *Volume Control* fallback
    , ((modm,                 xK_Page_Up),              flashText mySTConfig 1 "Vol up" >> safeSpawn "pactl" ["set-sink-volume",   "@DEFAULT_SINK@",   "+5%"])
    , ((modm,                 xK_Page_Up),              flashText mySTConfig 1 "Vol down" >> safeSpawn "pactl" ["set-sink-volume",   "@DEFAULT_SINK@",   "+5%"])
    , ((modm,                 xK_Page_Up),              safeSpawn "pactl" ["set-sink-volume",   "@DEFAULT_SINK@",   "+5%"])
    , ((modm,                 xK_Page_Down),            safeSpawn "pactl" ["set-sink-volume",   "@DEFAULT_SINK@",   "-5%"])
    , ((modm,                 xK_BackSpace),            safeSpawn "pactl" ["set-sink-mute",     "@DEFAULT_SINK@",   "toggle"])

    , ((modm .|. shiftMask,   xK_Page_Up),              safeSpawn "pactl" ["set-source-volume", "@DEFAULT_SOURCE@", "+5%"])
    , ((modm .|. shiftMask,   xK_Page_Down),            safeSpawn "pactl" ["set-source-volume", "@DEFAULT_SOURCE@", "-5%"])
    , ((modm .|. shiftMask,   xK_BackSpace),            safeSpawn "pactl" ["set-source-mute",   "@DEFAULT_SOURCE@", "toggle"])

    -- *MPRIS2 Player control*
    , ((0,                    xF86XK_AudioPlay),        safeSpawn "playerctl" ["play-pause"])
    , ((0,                    xF86XK_AudioStop),        safeSpawn "playerctl" ["stop"])
    , ((0,                    xF86XK_AudioNext),        safeSpawn "playerctl" ["next"])
    , ((0,                    xF86XK_AudioPrev),        safeSpawn "playerctl" ["previous"])
    -- fallback (TODO: remove after new keyboard arrives)
    , ((modm,                 xK_Insert),               safeSpawn "playerctl" ["play-pause"])
    , ((modm,                 xK_Home),                 safeSpawn "playerctl" ["stop"])
    , ((modm,                 xK_End),                  safeSpawn "playerctl" ["next"])
    , ((modm,                 xK_Delete),               safeSpawn "playerctl" ["previous"])
    ]
    ++
    -- *SwapWorkspaces*
    -- Swap current workspace to N
    [((modm .|. controlMask, k), windows $ swapWithCurrent i)
        | (i, k) <- zip (workspaces conf) [xK_1 .. xK_9]]


myMouse XConfig {XMonad.modMask = modm} = M.fromList
    -- *FlexibleResize*
    [ ((modm, button3), \w -> focus w >> FR.mouseResizeWindow w)
    ]

-- **ManageHooks**
myManageHook = manageDocks <+> windowHooks
    where
        newWindowBelow = insertPosition Below Newer

-- copy paste section
isDesktop      = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DESKTOP"
isDock         = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DOCK"
isOSD          = isInProperty "_NET_WM_WINDOW_TYPE" "_KDE_NET_WM_WINDOW_TYPE_ON_SCREEN_DISPLAY"
isNotification = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_NOTIFICATION"

sendToBottom :: Window -> X ()
sendToBottom window = withDisplay $ \display ->
      io $ lowerWindow display window

raiseWindow' :: Window -> X ()
raiseWindow' window = withDisplay $ \display ->
      io $ raiseWindow display window

allWindowsByType :: Query Bool -> X [Window]
allWindowsByType query = withDisplay $ \display -> do
      (_, _, windows) <- asks theRoot >>= io . queryTree display
      filterM (runQuery query) windows

sendToJustAboveDesktop :: Window -> X ()
sendToJustAboveDesktop window = do
      sendToBottom window
      allWindowsByType isDesktop >>= mapM_ sendToBottom

doWindowAction :: (Window -> X ()) -> ManageHook
doWindowAction action = ask >>= liftX . action >> idHook

raiseAll :: Query Bool -> X ()
raiseAll query = allWindowsByType query >>= mapM_ raiseWindow'

raiseAllNotificationsHook :: ManageHook
raiseAllNotificationsHook = liftX $ raiseAll isNotification >> idHook

raiseAllDialogsHook :: ManageHook
raiseAllDialogsHook = liftX $ raiseAll isDialog >> idHook
-- end of copy paste section

applicationSpecificHook :: ManageHook
applicationSpecificHook = composeOne
    [ className =? "albert"  -?> doFloatAt albertMagicH albertMagicV <+> removeBorder
    , className =? "krunner" -?> doIgnore >> doFloat <+> removeBorder
    , className =? "yakuake" -?> doFloat
    , resource  =? "plasma-desktop" -?> doFloat
    ]
        where
            -- Common Hooks
            removeBorder = hasBorder False

            -- Magic numbers
            albertMagicH = 0.3655
            albertMagicV = 0.25

windowTypeHook :: ManageHook
windowTypeHook = composeOne
    [ isNotification -?> doIgnore
    , isDock         -?> doWindowAction sendToJustAboveDesktop
    , isDesktop      -?> doWindowAction sendToBottom
    , isOSD          -?> doCenterFloat
    , isDialog       -?> doCenterFloat
    ]

windowHooks = applicationSpecificHook
    <+> windowTypeHook
    <+> raiseAllNotificationsHook
    <+> raiseAllDialogsHook

-- **Layouts**
-- TODO: find way to avoid xmobar when using XMonad.Layout.Fullscreen.fullscreenFocus Hook
myLayoutHooks = simplifyName . avoidStruts . smartBorders . smartSpacing . hiddenWindows
    where
        simplifyName = renamed [CutWordsLeft 2]
        smartSpacing = spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True
        --smartSpacing = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True

--myLayouts = myTall ||| myDishes ||| myTabbed ||| myDrawer
myLayouts = myTall ||| myDishes ||| myTabbed ||| myDrawer ||| mySpiral ||| myThree ||| myFull
    where
        myTall       = renamed [Replace "tall"]        $ Tall 1 (2/100) (1/2)
        myDishes     = renamed [Replace "dishes"]      $ Dishes 2 (1/8)
        myTabbed     = renamed [Replace "tabbed"]      $ tabbedBottom shrinkText myTabConfig
        myDrawer     = renamed [Replace "drawer"]      $ onBottom (simpleDrawer 0.05 0.5 (ClassName "konsole")) (Tall 1 (2/100) 0.5)
        mySpiral     = renamed [Replace "spiral"]      $ spiral (6/7)
        myThree      = renamed [Replace "three"]       $ ThreeColMid 1 (3/100) (1/2)
        myFull       = renamed [Replace "full"]        $ noBorders (FS.fullscreenFull Full)

        myTabConfig = def
            { fontName            = "xft:Fira Code:size=10:antialias=true"
            , activeBorderWidth   = 3
            , inactiveBorderWidth = 3
            , urgentBorderWidth   = 3
            , decoHeight          = 42

            , activeColor         = myFocusedColor
            , activeTextColor     = myFocusedTextColor
            , activeBorderColor   = myFocusedBorderColor

            , inactiveColor       = myUnfocusedColor
            , inactiveTextColor   = myUnfocusedTextColor
            , inactiveBorderColor = myUnfocusedBorderColor

            , urgentColor         = myUrgentColor
            , urgentTextColor     = myUrgentTextColor
            , urgentBorderColor   = myUrgentBorderColor
            }

-- **Hooks**
myHandleEventHook = FS.fullscreenEventHook <+> XMonad.Hooks.EwmhDesktops.fullscreenEventHook

myLogHook = xmobarLogHook -- <+> myFadeInactiveLogHook
    where
        xmobarLogHook = dynamicLogString myXmobarPP >>= xmonadPropLog
        -- myFadeInactiveLogHook = fadeInactiveLogHook 0.95

polybarLogHook = dynamicLogWithPP polybarPP

-- Polybar formatting functions

-- | Use polybar escape codes to output a string with given foreground and
-- background colors.
polybarColor :: String -- ^ foreground color: #rrggbb format -- TODO(alemedeiros): describe alpha notation for polybar
             -> String -- ^ background color
             -> String -- ^ outpout string
             -> String
polybarColor fg bg = wrap (fgStart++bgStart) (bgEnd++fgEnd)
    where
      (fgStart,fgEnd) | null fg = ("","")
                      | otherwise = ("%{F" ++ fg ++ "}","%{F-}")
      (bgStart,bgEnd) | null bg = ("","")
                      | otherwise = ("%{B" ++ bg ++ "}","%{B-}")

polybarUnderline :: String -- ^ line color
                 -> String -- ^ output string
                 -> String
polybarUnderline color = wrap underlineStart underlineEnd
    where
        underlineStart = "%{u" ++ color ++ "}%{+u}"
        underlineEnd   = "%{-u}%{u-}" -- reset color and underline


polybarOverline :: String -- ^ line color
                -> String -- ^ output string
                -> String
polybarOverline color = wrap overlineStart overlineEnd
    where
        overlineStart = "%{o" ++ color ++ "}%{+o}"
        overlineEnd   = "%{-o}%{o-}" -- reset color and overline

{-
-- | Encapsulate text with an action. The text will be displayed, and the
-- actions executed when the displayed text is clicked. Illegal input is not
-- filtered, allowing polybar to display any parse errors.
polybarAction :: String
                 -- ^ Command. (check which characters may mess this)
              -> String
                 -- ^ button-index 1-8, more than one button or any
                 -- other character will cause an error
              -> String
                 -- ^ Displayed / wrapped text
              -> String
polybarAction command button = wrap actionStart actionEnd
    where
        actionStart = "%{A" ++ button ++ ":" ++ command ++ ":}"
        actionEnd = "%{A}"
-}

polybarPP :: PP
polybarPP = def
    { ppCurrent = polybarOverline myAccentColor . polybarColor myFocusedTextColor "" . wrap "[" "]"
    , ppVisible = polybarOverline myUnfocusedTextColor . polybarColor myFocusedTextColor "" . wrap "[" "]"
    , ppHidden = polybarColor myUnfocusedTextColor ""
    , ppUrgent = polybarUnderline myUrgentColor
    , ppSep = " \xf6d8 "
    --, ppTitleSanitize = -- TODO implement similarly to xmobarStrip
    , ppOutput = \str -> appendFile "/tmp/.xmonad-log" $ UTF8.decodeString (str ++ "\n")
    }

-- pacman -Syu nitrogen picom trayer network-manager-applet
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "dunst &"
    -- spawnOnce "picom &"
    -- spawnOnce "nm-applet &"
    -- spawnOnce "volumeicon &"
    -- spawnOnce "stalonetray &"
    unsafeSpawn "bash $HOME/.xmonad/startup-applications"
    setWMName "LG3D"

-- **Xmobar**
myXmobarPP = xmobarPP
    { ppCurrent = xmobarColor myAccentColor "" . wrap "[" "]" . myXmobarWsAction
    , ppVisible = xmobarColor myFocusedTextColor "" . wrap "[" "]" . myXmobarWsAction
    , ppHidden  = myXmobarWsAction
    , ppUrgent  = xmobarColor myUrgentTextColor myUrgentColor . myXmobarWsAction
    , ppSep     = " | "
    , ppTitle   = xmobarColor myFocusedTextColor "" . shorten 80
    , ppLayout  = myXmobarLayoutAction
    }

myXmobarLayoutAction = leftClick . rightClick
    where
      -- Next Layout
      leftClick  = xmobarAction "xdotool key super+space" "1"
      -- Reset Layouts
      rightClick = xmobarAction "xdotool key super+shift+space" "3"

myXmobarWsAction wsId = leftClick . rightClick $ wsId
    where
        -- TODO: make it work for workspaces that don't have number names
        -- Change to workspace
        leftClick = xmobarAction ("xdotool key super+" ++ wsId) "1"
        -- Swap to workspace
        rightClick = xmobarAction ("xdotool key super+ctrl+" ++ wsId) "3"

-- **Colors**
-- TODO: update colors to Materia theme
myAccentColor          = "#1a73e8"
myBackgroundColor      = "#1f1f1f"

myFocusedColor         = myBackgroundColor
myFocusedTextColor     = "#dedede"
myFocusedBorderColor   = myAccentColor

myUnfocusedColor       = myBackgroundColor
myUnfocusedTextColor   = "#616161"
myUnfocusedBorderColor = "#424242"

myUrgentColor          = myAccentColor
myUrgentTextColor      = myFocusedTextColor
myUrgentBorderColor    = myUnfocusedBorderColor
