 
import React from "react";

function Login() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center">
      <h2 className="text-2xl font-bold mb-6">Login Page</h2>
      <form className="flex flex-col gap-4 w-72">
        <input
          type="email"
          placeholder="Email"
          className="border border-gray-300 rounded p-2"
        />
        <input
          type="password"
          placeholder="Password"
          className="border border-gray-300 rounded p-2"
        />
        <button
          type="submit"
          className="bg-blue-500 text-white py-2 rounded hover:bg-blue-600"
        >
          Login
        </button>
      </form>
    </div>
  );
}

export default Login;
