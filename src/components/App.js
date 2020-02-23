import React, { useState } from 'react';
import { createMuiTheme, ThemeProvider } from '@material-ui/core/styles';
import { colors, CssBaseline } from '@material-ui/core';
import Menu from './Menu'
import Content from './Content'

const lightTheme = createMuiTheme({
    palette: {
        type: "light",
        primary: colors.cyan,
        secondary: colors.pink,
    }
})

const darkTheme = createMuiTheme({
    palette: {
        type: "dark",
        primary: colors.cyan,
        secondary: colors.pink,
    }
})

function App() {
    const [theme, setTheme] = useState(darkTheme)

    const changeTheme = (dark) => {
        if (dark) {
            setTheme(darkTheme)
        } else {
            setTheme(lightTheme)
        }
    }

    return (
        <ThemeProvider theme={theme}>
            <CssBaseline/>
            <div>
                <Menu changeTheme={changeTheme} />
                <Content />
            </div>
        </ThemeProvider>
    )
}

export default App;