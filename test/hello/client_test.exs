defmodule Hello.ClientTest do
  use Hello.DataCase

  alias Hello.Client

  describe "users" do
    alias Hello.Client.User

    @valid_attrs %{age: 42, name: "some name"}
    @update_attrs %{age: 43, name: "some updated name"}
    @invalid_attrs %{age: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Client.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Client.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Client.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Client.create_user(@valid_attrs)
      assert user.age == 42
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Client.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Client.update_user(user, @update_attrs)
      assert user.age == 43
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Client.update_user(user, @invalid_attrs)
      assert user == Client.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Client.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Client.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Client.change_user(user)
    end
  end
end
