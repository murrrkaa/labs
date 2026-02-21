//11. Имеется план школьного сочинения, записанный с  помощью
//дерева.Два друга решили написать сочинение вместе.Каждый из
//них независимо  взял  несколько  частей, задавая  их  корнями
//соответствующих    поддеревьев.Требуется    выдать    план
//неохваченной части сочинения(9).
//Бабина Мария ПС-21

#include <sstream>
#include <iostream>
#include <vector>
#include <fstream>
#include <string>

struct NodeTree
{
    std::string node;
    std::vector<NodeTree*> children;
    NodeTree* parent;

    NodeTree(std::string& node, NodeTree* parent = nullptr) : node(node), parent(parent) {}
};


void addChild(NodeTree* parent, NodeTree* child)
{
    parent->children.push_back(child);
    child->parent = parent;
}


void readTreeFromFile(std::ifstream& file, NodeTree*& root)
{
    std::vector<NodeTree*> parentsStack;
    std::string str;

    while (std::getline(file, str))
    {
        int currentDepth = 0;
        while (currentDepth < str.size() && str[currentDepth] == '.')
        {
            currentDepth++;
        }

        std::string nodeName = str.substr(currentDepth);

        NodeTree* newNode = new NodeTree(nodeName);

        if (currentDepth == 0)
        {
            root = newNode;
            parentsStack.push_back(newNode);
        }
        else
        {
            if (currentDepth > parentsStack.size() - 1)
            {
                addChild(parentsStack.back(), newNode);
            }
            else
            {
                parentsStack.resize(currentDepth);
                addChild(parentsStack.back(), newNode);
            }
            parentsStack.push_back(newNode);
        }
    }
}

void removeEmptyParents(NodeTree*& node)
{
    if (node == nullptr) return;

    NodeTree* parent = node->parent;

    delete node;
    node = nullptr;

    if (parent != nullptr && parent->children.empty())
    {
        removeEmptyParents(parent);
    }
}


void removeSubtrees(NodeTree*& parent, const std::vector<std::string>& nodeNames)
{
    if (parent == nullptr) return;

    bool childRemoved = false;

    if (std::find(nodeNames.begin(), nodeNames.end(), parent->node) != nodeNames.end())
    {
        delete parent;
        parent = nullptr;
        return;
    }

    for (int i = 0; i != parent->children.size();)
    {
        NodeTree* child = parent->children[i];
        if (std::find(nodeNames.begin(), nodeNames.end(), child->node) != nodeNames.end())
        {
            delete child;
            parent->children.erase(parent->children.begin() + i);
            childRemoved = true;

        }
        else
        {
            removeSubtrees(child, nodeNames);
            if (child == nullptr)
            {
                parent->children.erase(parent->children.begin() + i);
                childRemoved = true;
            }
            else
            {
                ++i;
            }
        }
    }
    if (parent->children.empty() && childRemoved)
    {
        removeEmptyParents(parent);
    }
}

void getSubtreeNames(std::vector<std::string>& subtreeNames, const std::string& friendName)
{
    std::cout << "Введите имена узлов, выбранных " << friendName << " \n";
    std::string inputLine;
    std::getline(std::cin >> std::ws, inputLine);

    std::istringstream iss(inputLine);
    std::string name;
    while (iss >> name)
    {
        subtreeNames.push_back(name);
    }
}

void printTree(NodeTree* node, int level = 0)
{
    if (node == nullptr)
    {
        return;
    }

    for (int i = 0; i < level; ++i)
    {
        std::cout << "  ";
    }
    std::cout << node->node << "\n";

    for (int i = 0; i < node->children.size(); ++i)
    {
        printTree(node->children[i], level + 1);
    }
}

int main()
{
    setlocale(LC_ALL, "ru");

    while (true)
    {
        std::string path;
        std::cout << "Введите путь к файлу:\n";
        std::cin >> path;
        std::ifstream file;
        file.open(path);

        NodeTree* root = nullptr;

        if (file.is_open())
        {
            readTreeFromFile(file, root);
            if (root)
            {
                std::cout << "Содержимое дерева:" << "\n";
                printTree(root);

                std::vector<std::string> friendSubtrees;

                getSubtreeNames(friendSubtrees, "первым другом");
                getSubtreeNames(friendSubtrees, "вторым другом");

                removeSubtrees(root, friendSubtrees);

                if (root == nullptr)
                {
                    std::cout << "Дерево пустое!" << "\n";
                }
                else
                {
                    std::cout << "Обновлённое дерево:" << "\n";
                    printTree(root);
                }
                std::string isContinue;
                std::cout << "Продолжить: yes/no" << "\n";
                std::cin >> isContinue;
                if (isContinue == "no")
                {
                    break;
                    return 0;
                }
            }
            else
            {
                std::cout << "Не удалось построить дерево" << "\n";
            }
        }
        else
        {
            std::cout << "Не удалось открыть файл!";
            return 1;
        }
    }
}


