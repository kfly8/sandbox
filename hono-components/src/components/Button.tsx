import { css } from 'hono/css'

export const Button = () => {

  const buttonClass = css`
    padding: 10px 20px;
    background-color: #007bff;
  `

  return (
    <>
      <button class={buttonClass}>Click me</button>
    </>
  );
}
