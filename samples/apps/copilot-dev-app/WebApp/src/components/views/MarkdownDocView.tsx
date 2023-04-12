import { makeStyles } from '@fluentui/react-components';
import { FC } from 'react';
import { ReactMarkdown } from 'react-markdown/lib/react-markdown';

const useClasses = makeStyles({
    container: {
        display: 'flex',
        flexDirection: 'row',
        alignContent: 'start',
        justifyContent: 'space-between',
        width: '100%',
        height: '100%',
        Flex: '1',
    },
});

export const MarkdownDocView: FC = () => {
    const classes = useClasses();

    const content = `
    #Here is the markdown content
    ##<replace it with code to load the file>
    - list item 
    - list item
    `;

    return (
        <div style={{ width: '65%' }} className={classes.container}>
            <ReactMarkdown>{content}</ReactMarkdown>
        </div>
    );
};
