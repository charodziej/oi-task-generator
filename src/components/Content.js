import React, { useState } from 'react'
import { colors, makeStyles, Paper, Button, Typography, Fab, Link, Dialog, CircularProgress } from '@material-ui/core'
import AddIcon from '@material-ui/icons/Add'
import SingleLineInput from './SingleLineInput'
import MultiLineInput from './MultiLineInput'
import SelectInput from './SelectInput'
import DateInput from './DateInput'
import TestInput from './TestInput'
import format from 'date-fns/format'

const useStyles = makeStyles(theme => ({
    container: {
        [theme.breakpoints.up('md')]: {
            margin: theme.spacing(2),
        },
        padding: theme.spacing(2),
        flexGrow: 1,
        display: "flex",
        maxWidth: 1000,
        flexDirection: "column"
    },
    submit: {
        color: theme.palette.getContrastText(colors.green[500]),
        backgroundColor: colors.green[500],
        '&:hover': {
            backgroundColor: colors.green[700],
        },
        marginLeft: "auto"
    }
}))

export default function Content() {
    const templates = [
        { value: "staszic", label: "Staszic" },
        { value: "oi", label: "OI" },
    ]

    const classes = useStyles()
    const [loading, setLoading] = useState(false)
    const [template, setTemplate] = useState()
    const [contest, setContest] = useState("")
    const [contestDay, _setContestDay] = useState(0)
    const setContestDay = (val) => _setContestDay(parseInt(val))
    const [date, setDate] = useState(new Date())
    const [title, setTitle] = useState("")
    const [ram, setRam] = useState("")
    const [content, setContent] = useState("")
    const [input, setInput] = useState("")
    const [output, setOutput] = useState("")
    const [tests, setTests] = useState([["", ""], ["", ""], ["", ""]])

    const [url, setUrl] = useState("")

    const setTest = (val, loc, index) => {
        const test = Array.from(tests[index])
        test[loc] = val
        const newTests = Array.from(tests)
        newTests[index] = test
        setTests(newTests)
    }

    const uploadSettings = async () => {
        setLoading(true)
        const data = {
            template,
            contest,
            day: contestDay,
            date: format(date, "dd.MM.yyy"),
            title,
            ram,
            content,
            input,
            output,
            tests
        }
        console.log(data)

        /*
        for (const key in data) {
            if (data.hasOwnProperty(key)) {
                const element = data[key];
                if (!element) {

                }
            }
        }
        */

        try {
            let request = new URLSearchParams()
            request.append("content", JSON.stringify(data))

            const response = await fetch("http://lokinado.ct8.pl/OI-styleTaskGenerator/process.php", {
                method: "POST",
                body: request
            })
            const result = await response.json()
            console.log(result)

            if (result.status === "OK") {
                const link = document.createElement('a')
                link.href = result.link
                link.setAttribute('download', 'task.pdf')
                document.body.appendChild(link)
                link.click()
                link.parentNode.removeChild(link)

                setUrl(result.link)
            } 
        } catch (err) {
            console.log(err)
        }
        setLoading(false)
    }

    const inputs = [
        { Component: SelectInput,     label: "Template",           value: template,   onChange: setTemplate, extra: { options: templates } },
        { Component: SingleLineInput, label: "Contest name",       value: contest,    onChange: setContest },
        { Component: SingleLineInput, label: "Contest day",        value: contestDay, onChange: setContestDay, extra: { type: "number" } },
        { Component: DateInput,       label: "Date",               value: date,       onChange: setDate },
        { Component: SingleLineInput, label: "Task title",         value: title,      onChange: setTitle },
        { Component: SingleLineInput, label: "RAM amount",         value: ram,        onChange: setRam },
        { Component: MultiLineInput,  label: "Task description",   value: content,    onChange: setContent },
        { Component: MultiLineInput,  label: "Input description",  value: input,      onChange: setInput },
        { Component: MultiLineInput,  label: "Output description", value: output,     onChange: setOutput },
    ]

    return (
        <div style={{
            display: "flex",
            justifyContent: "center",
        }}>
            <Paper className={classes.container}>
                {inputs.map(({ Component, label, value, onChange, extra }) => (
                    <Component 
                        key={label}
                        label={label}
                        value={value}
                        onChange={onChange}
                        {...extra}
                    />
                ))}

                {tests.map((test, index) => (
                    <React.Fragment key={index}> 
                        <Typography>
                            Task number {index}:
                        </Typography>
                        <TestInput 
                            input={test[0]}
                            output={test[1]}
                            onChange={(val, loc) => setTest(val, loc, index)}
                            onRemove={() => setTests(tests.filter((_, i) => i !== index))}
                        />
                    </React.Fragment>
                ))}

                <Fab 
                    color="primary"
                    variant="extended"
                    size="small"
                    style={{
                        margin: 16,
                    }}
                    onClick={() => setTests([ ...tests, ["", ""] ])}
                >
                    <AddIcon />
                    Add test
                </Fab>

                <Button
                    className={classes.submit}
                    onClick={uploadSettings}
                >
                    Submit
                </Button>
                {url &&
                <Link href={url}>
                    Download!    
                </Link>}
            </Paper>
            <Dialog open={loading} >
                <div
                    style={{
                        padding: 16
                    }}
                >
                    <CircularProgress />
                </div>
            </Dialog>
        </div>
    )
}
