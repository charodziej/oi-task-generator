import React, { useState } from 'react'
import { AppBar, Toolbar, Typography, makeStyles, Switch, useTheme, Drawer, IconButton, FormControlLabel, Link } from '@material-ui/core'
import MenuIcon from '@material-ui/icons/Menu';
import FavoriteIcon from '@material-ui/icons/Favorite';

const useStyles = makeStyles(theme => ({
    title: {
        color: theme.palette.primary.contrastText,
        flexGrow: 1,
    },
    menuButton: {
        color: theme.palette.primary.contrastText,
        marginRight: theme.spacing(2),
    },
    drawer: {
        width: 250, 
        padding: theme.spacing(2)
    }
}))

export default function Menu({ changeTheme }) {
    const classes = useStyles()
    const theme = useTheme()
    const [drawer, setDrawer] = useState(false)

    return (
        <div>
            <AppBar position="static">
                <Toolbar>
                    <IconButton
                        className={classes.menuButton}
                        onClick={() => setDrawer(true)}
                    >
                        <MenuIcon />
                    </IconButton>
                    <Typography variant="h6" className={classes.title}>
                        OI-style Task Generator
                    </Typography>
                </Toolbar>
            </AppBar>
            <Drawer
                open={drawer}
                onClose={() => setDrawer(false)}
            >
                <div className={classes.drawer}>
                    <FormControlLabel
                        control={
                            <Switch 
                                checked={theme.palette.type === "dark"}
                                onChange={(evt) => changeTheme(evt.target.checked)}
                            />
                        }
                        label="Dark mode"
                    />
                    <Typography 
                        component="p"
                        variant="caption" 
                        style={{
                            marginTop: 8,
                            marginBottom: 8, 
                            textAlign: "center"
                        }}
                    >
                        Made with {<FavoriteIcon style={{ fontSize: 12 }}/>} by <br />
                        Lokinado & charodziej <br />
                        <Link href="https://github.com/charodziej/oi-task-generator">
                            View source
                        </Link>
                    </Typography>
                </div>
            </Drawer>
        </div>
    )
}
