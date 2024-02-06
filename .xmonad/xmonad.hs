import XMonad
import XMonad.Layout.Fullscreen
    ( fullscreenEventHook, fullscreenManageHook, fullscreenSupport, fullscreenFull )
import Data.Monoid ()
import System.Exit ()
import XMonad.Util.SpawnOnce ( spawnOnce )
import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_MonBrightnessDown, xF86XK_MonBrightnessUp, xF86XK_AudioPlay, xF86XK_AudioPrev, xF86XK_AudioNext)
import XMonad.Hooks.EwmhDesktops ( ewmh )
import Control.Monad ( join, when )
import XMonad.Layout.NoBorders
import XMonad.Actions.CycleWS
import XMonad.Hooks.ManageDocks
    ( avoidStruts, docks, manageDocks, Direction2D(D, L, R, U) )
import XMonad.Hooks.ManageHelpers ( doFullFloat, isFullscreen )
import XMonad.Layout.Spacing ( spacingRaw, Border(Border) )
import XMonad.Layout.Gaps
    ( Direction2D(D, L, R, U),
      gaps,
      setGaps,
      GapMessage(DecGap, ToggleGaps, IncGap) )
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Maybe (maybeToList)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.Run (runProcessWithInput)
import XMonad.Util.EZConfig(additionalKeys)
import qualified Data.Map as M
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth   = 2


-- Mod key
myModMask       = mod4Mask


-- Workspaces
myWorkspaces    = ["\63083", "\63288", "\63306", "\61723", "\63107", "\63601", "\63391", "\61713", "\61884"]
-- myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#3b4252"
myFocusedBorderColor = "#767e91"

addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]


-- Clipboard history
clipboardy :: MonadIO m => m () -- Don't question it 
clipboardy = spawn "rofi -modi \"\63053 :greenclip print\" -show \"\63053 \" -run-command '{cmd}' -theme ~/.config/rofi/config.rasi"

-- FullScreen Support
toggleFull = withFocused (\windowId -> do
    { floats <- gets (W.floating . windowset);
        if windowId `M.member` floats
        then withFocused $ windows . W.sink
        else withFocused $ windows . (flip W.float $ W.RationalRect 0 0 1 1) })

sendMessageWithWindowTitle :: X ()
sendMessageWithWindowTitle = withFocused $ \window -> do
    title <- runProcessWithInput "xdotool" ["getwindowname", show window] ""
    spawn $ "notify-send 'Current Window ' '" ++ title ++ "'"


-- Screenshot functions
maimcopy = spawn "maim -s | xclip -selection clipboard -t image/png && notify-send \"Screenshot\" \"Copied to Clipboard\" -i flameshot"
maimsave = spawn "maim -s ~/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot\" \"Saved to Home\" -i flameshot"


myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    
    [ 

    -- lock screen
    ((modm,               xK_F1    ), spawn "betterlockscreen -l")

    -- workspaces
    , ((modm,               xK_Right),  nextWS)
    , ((modm,               xK_Left),    prevWS)
    , ((modm .|. shiftMask, xK_Right),  shiftToNext)
    , ((modm .|. shiftMask, xK_Left),    shiftToPrev)

    -- launch rofi
    , ((modm,               xK_o     ), spawn "rofi -show drun -theme .config/rofi.xmonad/config.rasi")
    , ((modm .|. shiftMask, xK_o),  spawn "rofi -show run -theme .config/rofi.xmonad/config.rasi")
    , ((modm .|. shiftMask, xK_Tab),  spawn "rofi -show window -theme .config/rofi.xmonad/config.rasi")
    , ((modm .|. controlMask, xK_e),  spawn "rofi -show emoji -theme .config/rofi.xmonad/config.rasi")
    , ((modm,               xK_c),  spawn "rofi -show calc -theme .config/rofi.xmonad/config.rasi")
    , ((modm .|. shiftMask, xK_s),  spawn "rofi -show ssh -theme .config/rofi.xmonad/config.rasi")
    , ((modm .|. controlMask, xK_k),  spawn "~/bin/rofi-kill -theme .config/rofi.xmonad/config.rasi")
    , ((modm .|. controlMask, xK_m),  spawn "~/bin/rofi-man -theme .config/rofi.xmonad/config.rasi")
    , ((modm .|. controlMask, xK_w),  spawn "~/bin/rofi-websearch -theme .config/rofi.xmonad/config.rasi")

    -- Select audio output
    , ((modm              , xK_s),  spawn "rofi -show rofi-sound -modi rofi-sound:~/bin/rofi-sound-output-chooser -theme .config/rofi.xmonad/config.rasi")

    -- Audio keys
    , ((0,                    xF86XK_AudioPlay), spawn "playerctl play-pause")
    , ((0,                    xF86XK_AudioPrev), spawn "playerctl previous")
    , ((0,                    xF86XK_AudioNext), spawn "playerctl next")
    , ((0,                    xF86XK_AudioRaiseVolume), spawn "~/bin/changevolume up")
    , ((0,                    xF86XK_AudioLowerVolume), spawn "~/bin/changevolume down")
    , ((0,                    xF86XK_AudioMute), spawn "~/bin/changevolume mute")

    -- Get current window info
    , ((modm,                    xK_p), sendMessageWithWindowTitle)

    -- Screenshot
    , ((0,                    xK_Print), maimcopy)
    , ((modm,                 xK_Print), maimsave)

    -- My Stuff
    , ((modm,               xK_b     ), spawn "exec ~/bin/bartoggle")
    , ((modm .|. shiftMask, xK_a     ), clipboardy)

    -- Turn do not disturb on and off
    , ((modm,               xK_d     ), spawn "exec ~/bin/do_not_disturb.sh")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- GAPS!!!
    , ((modm .|. controlMask, xK_g), sendMessage $ ToggleGaps)               -- toggle all gaps
    , ((modm .|. shiftMask, xK_g), sendMessage $ setGaps [(L,30), (R,30), (U,40), (D,20)]) -- reset the GapSpec
    
    , ((modm .|. controlMask, xK_l), sendMessage $ IncGap 10 L)              -- increment the left-hand gap
    , ((modm .|. shiftMask, xK_l     ), sendMessage $ DecGap 10 L)           -- decrement the left-hand gap
    
    , ((modm .|. controlMask, xK_t), sendMessage $ IncGap 10 U)              -- increment the top gap
    , ((modm .|. shiftMask, xK_t     ), sendMessage $ DecGap 10 U)           -- decrement the top gap
    
    , ((modm .|. controlMask, xK_b), sendMessage $ IncGap 10 D)              -- increment the bottom gap
    , ((modm .|. shiftMask, xK_b     ), sendMessage $ DecGap 10 D)           -- decrement the bottom gap

    , ((modm .|. controlMask, xK_p), sendMessage $ IncGap 10 R)              -- increment the right-hand gap
    , ((modm .|. shiftMask, xK_p     ), sendMessage $ DecGap 10 R)           -- decrement the right-hand gap

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Open programs
    , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_f   ), spawn "alacritty --command lf")
    , ((modm .|. shiftMask, xK_f   ), spawn "thunar")


    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), spawn "rofi -show power-menu -modi power-menu:~/bin/rofi-power-menu")

    , ((modm,               xK_F2    ), spawn "sleep 0.3 && ~/bin/loadwallpaper")
    
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Full Screen
    , ((modm,               xK_v    ), toggleFull)

    -- Change keyboard layout
    , ((modm              , xK_i     ), spawn "bash ~/bin/layout_switch.sh")
    , ((modm .|. shiftMask, xK_i     ), spawn "bash ~/bin/changelayout")
    , ((modm              , xK_u     ), spawn "notify-send 'Xmodmap!' 'Starting xmodmap.' && xmodmap ~/.Xmodmap")

    
    ]


    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    
    
    ++
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    

    
    


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts(tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = fullscreenManageHook <+> manageDocks <+> composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "Alacritty" --> doFullFloat
    , isFullscreen --> doFullFloat
                                 ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawn "xsetroot -cursor_name left_ptr"
  setWMName "LG3D"
  spawnOnce "exec ~/bin/bartoggle"
  spawnOnce "exec ~/bin/loadwallpaper"
  spawnOnce "picom"
  spawnOnce "greenclip daemon"
  spawnOnce "dunst"
  spawnOnce "numlockx"
  spawnOnce "xmodmap ~/.Xmodmap"
  -- spawnOnce "nvidia-settings &"
  spawnOnce "slack"
  spawnOnce "discord --start-minimized"
  spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"

  

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad $ fullscreenSupport $ docks $ ewmh defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        manageHook = myManageHook, 
        layoutHook = gaps [(L,30), (R,30), (U,40), (D,20)] $ spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True $ smartBorders $ myLayout,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook >> addEWMHFullscreen
    }

