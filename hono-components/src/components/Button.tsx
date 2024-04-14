import { css } from 'hono/css'

type Props = {
  size: 'large' | 'small'
  label: string
}

export const createButtonProps = (params: URLSearchParams) : Props => {
  return {
    size: params.get('size') as Props['size'],
    label: params.get('label') as Props['label'],
  }
}

export const Button = (props : Props) => {

  const buttonBaseClass = css`
    padding: 10px 20px;
  `

  const buttonSize = {
    large: css`font-size: 20px;`,
    small: css`font-size: 12px;`,
  }

  const buttonClass = css`${buttonBaseClass} ${buttonSize[props.size]}`

  return (
    <>
      <button class={buttonClass}>{props.label}</button>
    </>
  );
}
