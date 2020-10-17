import React from 'react';
import {View, Text, StyleSheet} from 'react-native';
import {useNavigation} from '@react-navigation/native';
import {BorderlessButton} from 'react-native-gesture-handler';
import {Feather} from '@expo/vector-icons';

interface IHeaderProps {
  title: string;
  showCancel?: boolean;
}

const Header = (props: IHeaderProps) => {
  const navigation = useNavigation();

  return (
    <View style={styles.container}>
      <BorderlessButton onPress={() => navigation.goBack()}>
        <Feather name="arrow-left" size={24} color="#15b6d6" />
      </BorderlessButton>

      <Text style={styles.title}>{props.title}</Text>

      {!props.showCancel ? (
        <BorderlessButton onPress={() => navigation.navigate('OrphanagesMap')}>
          <Feather name="x" size={24} color="#ff669d" />
        </BorderlessButton>
      ) : <View />}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 24,
    backgroundColor: '#f9fafc',
    borderBottomWidth: 1,
    borderColor: '#dde4f0',
    paddingTop: 44,
  },

  title: {
    fontWeight: 'bold',
    color: '#8fa7b3',
    fontSize: 16,
  }
});

export default Header;
